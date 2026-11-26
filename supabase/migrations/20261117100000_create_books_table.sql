CREATE TABLE public.books(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    title text NOT NULL CHECK (length(trim(title)) > 0),
    authors text[] NOT NULL CHECK (array_length(authors, 1) > 0),
    isbn_10 varchar(10) UNIQUE,
    isbn_13 varchar(13) UNIQUE,
    page_count integer,
    publication_year integer,
    cover_url text,
    open_library_key text UNIQUE,
    google_books_key text UNIQUE
);

-- Moddatetime trigger
CREATE TRIGGER handle_updated_at_books
    BEFORE UPDATE ON public.books
    FOR EACH ROW
    EXECUTE FUNCTION extensions.moddatetime(updated_at);

