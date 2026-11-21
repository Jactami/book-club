CREATE TABLE public.proposals(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    round_id uuid NOT NULL REFERENCES public.voting_rounds(id) ON DELETE CASCADE,
    book_id uuid NOT NULL REFERENCES public.books(id) ON DELETE CASCADE,
    user_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    UNIQUE (round_id, book_id) -- Ensure that a book can only be proposed once per voting round
);

-- Moddatetime trigger
CREATE TRIGGER handle_updated_at_proposals
    BEFORE UPDATE ON public.proposals
    FOR EACH ROW
    EXECUTE FUNCTION extensions.moddatetime(updated_at);

-- TODO: Ensure that a user cannot propose more than the maximum number of proposals per voting round
