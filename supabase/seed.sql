-- Users
INSERT INTO auth.users(id, email, encrypted_password, raw_user_meta_data)
VALUES
    ('00000000-0000-0000-0000-000000000000', 'user@example.com', '$2a$10$example_hash', '{"first_name": "John", "last_name": "Doe"}'),
('00000000-0000-0000-0000-000000000002', 'user2@example.com', '$2a$10$example_hash', '{"first_name": "Max", "last_name": "Mustermann"}');

-- Books
INSERT INTO public.books(title, authors, isbn_10, isbn_13, pages, published, cover)
    VALUES ('Faserland', '{"Christian Kracht"}', '3596185327', '9783596185320', 176, 1995, 'https://covers.openlibrary.org/b/id/1003328-L.jpg');

