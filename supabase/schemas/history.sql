CREATE TABLE public.history(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    book_id uuid NOT NULL REFERENCES public.books(id) ON DELETE CASCADE UNIQUE,
    period date NOT NULL UNIQUE
    -- TODO: add round_id vs. more flexible approach to track previous history
);

-- Moddatetime trigger
CREATE TRIGGER handle_updated_at_history
    BEFORE UPDATE ON public.history
    FOR EACH ROW
    EXECUTE FUNCTION extensions.moddatetime(updated_at);

