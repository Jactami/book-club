CREATE TABLE public.books(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    isbn_10 varchar(10) UNIQUE,
    isbn_13 varchar(13) UNIQUE,
    title text NOT NULL,
    authors text[] NOT NULL,
    pages integer,
    published integer,
    cover text
);

CREATE TRIGGER handle_updated_at_books
    BEFORE UPDATE ON public.books
    FOR EACH ROW
    EXECUTE FUNCTION extensions.moddatetime('updated_at');

