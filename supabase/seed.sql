-- Users
INSERT INTO auth.users(id, email, encrypted_password, raw_user_meta_data)
VALUES
    ('00000000-0000-0000-0000-000000000000', 'user@example.com', '$2a$10$example_hash', '{"first_name": "John", "last_name": "Doe"}'),
('00000000-0000-0000-0000-000000000002', 'user2@example.com', '$2a$10$example_hash', '{"first_name": "Max", "last_name": "Mustermann"}');

-- Books
INSERT INTO public.books(id, title, authors, isbn_10, isbn_13, pages, published, cover)
VALUES
    ('00000000-0000-0000-0000-000000000010', 'Faserland', '{"Christian Kracht"}', '3596185327', '9783596185320', 176, 1995, 'https://covers.openlibrary.org/b/id/1003328-L.jpg'),
('00000000-0000-0000-0000-000000000011', 'Frankenstein', '{"Mary Shelly"}', '3730613103', '9783730613108', 304, 1818, 'https://covers.openlibrary.org/b/id/12356249-L.jpg'),
('00000000-0000-0000-0000-000000000012', 'Herr der Ringe', '{"J.R.R. Tolkien"}', '3608988009', '9783608988000', 1568, 1954, 'https://covers.openlibrary.org/b/id/14625765-L.jpg'),
('00000000-0000-0000-0000-000000000013', 'Die Känguru-Chroniken', '{"Marc-Uwe Kling"}', '3548372570', '9783548372570', 272, 2009, 'https://covers.openlibrary.org/b/id/10479502-L.jpg');

