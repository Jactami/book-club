CREATE TABLE public.votes(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    proposal_id uuid NOT NULL REFERENCES public.proposals(id) ON DELETE CASCADE,
    user_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    points smallint NOT NULL CHECK (points BETWEEN 1 AND 3), -- TODO: point spectrum is fixed for the moment
    UNIQUE (user_id, proposal_id) -- Ensure that a user can only vote once for a proposal
);

-- Moddatetime trigger
CREATE TRIGGER handle_updated_at_votes
    BEFORE UPDATE ON public.votes
    FOR EACH ROW
    EXECUTE FUNCTION extensions.moddatetime(updated_at);

-- Ensure that a user can not vote for own proposals
CREATE FUNCTION public.check_vote_own_proposal()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    SECURITY DEFINER
    SET search_path = public
    AS $$
BEGIN
    IF(NEW.user_id =(
        SELECT
            user_id
        FROM
            public.proposals
        WHERE
            id = NEW.proposal_id)) THEN
        RAISE EXCEPTION 'User cannot vote for own proposal';
    END IF;
    RETURN new;
END;
$$;

CREATE TRIGGER before_insert_vote_own_proposal
    BEFORE INSERT ON public.votes
    FOR EACH ROW
    EXECUTE PROCEDURE public.check_vote_own_proposal();

