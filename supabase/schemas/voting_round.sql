CREATE TABLE public.voting_rounds(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    period date NOT NULL UNIQUE,
    is_open boolean NOT NULL DEFAULT TRUE
);

-- Ensure that only one voting round can be open at a time
CREATE UNIQUE INDEX voting_rounds_one_open ON voting_rounds((TRUE))
WHERE
    is_open = TRUE;

-- Moddatetime trigger
CREATE TRIGGER handle_updated_at_voting_rounds
    BEFORE UPDATE ON public.voting_rounds
    FOR EACH ROW
    EXECUTE FUNCTION extensions.moddatetime(updated_at);

