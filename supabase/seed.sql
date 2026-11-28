-- Users
INSERT INTO auth.users(instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, recovery_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, email_change, email_change_token_new, recovery_token)
VALUES
    ('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'john@doe.com', crypt('password', gen_salt('bf')), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '{"provider":"email","providers":["email"]}', '{"first_name": "John", "last_name": "Doe"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '', '', '', ''),
('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000001', 'authenticated', 'authenticated', 'max@mustermann.com', crypt('password', gen_salt('bf')), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '{"provider":"email","providers":["email"]}', '{"first_name": "Max", "last_name": "Mustermann"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '', '', '', '');

INSERT INTO auth.identities(id, user_id, provider_id, identity_data, provider, last_sign_in_at, created_at, updated_at)(
    SELECT
        uuid_generate_v4(),
        id,
        id,
        format('{"sub":"%s","email":"%s"}', id::text, email)::jsonb,
        'email',
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    FROM
        auth.users);

-- Books
INSERT INTO public.books(id, title, authors, isbn_10, isbn_13, page_count, publication_year, cover_url)
VALUES
    ('00000000-0000-0000-0000-000000000000', 'Faserland', '{"Christian Kracht"}', '3596185327', '9783596185320', 176, 1995, 'https://covers.openlibrary.org/b/id/1003328-L.jpg'),
('00000000-0000-0000-0000-000000000001', 'Frankenstein', '{"Mary Shelly"}', '3730613103', '9783730613108', 304, 1818, 'https://covers.openlibrary.org/b/id/12356249-L.jpg'),
('00000000-0000-0000-0000-000000000002', 'Herr der Ringe', '{"J.R.R. Tolkien"}', '3608988009', '9783608988000', 1568, 1954, 'https://covers.openlibrary.org/b/id/14625765-L.jpg'),
('00000000-0000-0000-0000-000000000003', 'Die Känguru-Chroniken', '{"Marc-Uwe Kling"}', '3548372570', '9783548372570', 272, 2009, 'https://covers.openlibrary.org/b/id/10479502-L.jpg'),
('00000000-0000-0000-0000-000000000004', 'Manifest der kommunistischen Partei', '{"Karl Marx", "Friedrich Engels"}', '3868200339', '9783868200331', 144, 1848, 'https://covers.openlibrary.org/b/id/13525032-L.jpg'),
('00000000-0000-0000-0000-000000000005', 'Stolz und Vorurteil', '{"Jane Austen"}', '3868206388', '9783868206388', 400, 1813, NULL),
('00000000-0000-0000-0000-000000000006', 'Der kleine Prinz', '{"Antoine de Saint-Exupéry"}', '2631124597', '9782631124595', 96, 1943, 'https://covers.openlibrary.org/b/id/10708272-L.jpg'),
('00000000-0000-0000-0000-000000000007', 'Er ist wieder da', '{"Timur Vermes"}', '3404171780', '9783404171781', 400, 2014, 'https://covers.openlibrary.org/b/id/7240199-L.jpg');

-- Voting rounds
INSERT INTO public.voting_rounds(id, period, is_open)
    VALUES ('00000000-0000-0000-0000-000000000000', '2026-12-01', TRUE);

-- Proposals
INSERT INTO public.proposals(id, round_id, book_id, user_id)
VALUES
    ('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000000'),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000000'),
('00000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000000'),
('00000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000001');

-- Votes
INSERT INTO public.votes(id, proposal_id, user_id, points)
    VALUES ('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 3);

-- History
INSERT INTO public.history(id, book_id, period)
VALUES
    ('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', '2027-01-01'),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', '2026-12-01'),
('00000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000002', '2026-11-01'),
('00000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000003', '2025-08-01');

