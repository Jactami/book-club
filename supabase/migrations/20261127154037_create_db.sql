SET local check_function_bodies = off;

CREATE EXTENSION "moddatetime" SCHEMA "extensions";

CREATE TABLE "public"."books" (
  "id"               uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "created_at"       timestamp with time zone DEFAULT now(),
  "updated_at"       timestamp with time zone,
  "title"            text                     NOT NULL,
  "authors"          text[]                   NOT NULL,
  "isbn_10"          character varying(10),
  "isbn_13"          character varying(13),
  "page_count"       integer,
  "publication_year" integer,
  "cover_url"        text,
  "open_library_key" text,
  "google_books_key" text,
  CONSTRAINT "books_authors_check" CHECK ((array_length(authors, 1) > 0)),
  CONSTRAINT "books_google_books_key_key" UNIQUE (google_books_key),
  CONSTRAINT "books_isbn_10_key" UNIQUE (isbn_10),
  CONSTRAINT "books_isbn_13_key" UNIQUE (isbn_13),
  CONSTRAINT "books_open_library_key_key" UNIQUE (open_library_key),
  CONSTRAINT "books_pkey" PRIMARY KEY (id),
  CONSTRAINT "books_title_check" CHECK ((length(TRIM(BOTH FROM title)) > 0))
);

CREATE TABLE "public"."history" (
  "id"         uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "created_at" timestamp with time zone DEFAULT now(),
  "updated_at" timestamp with time zone,
  "book_id"    uuid                     NOT NULL,
  "period"     date                     NOT NULL,
  CONSTRAINT "history_book_id_key" UNIQUE (book_id),
  CONSTRAINT "history_period_key" UNIQUE (period),
  CONSTRAINT "history_pkey" PRIMARY KEY (id)
);

CREATE TABLE "public"."profiles" (
  "id"         uuid                     NOT NULL,
  "created_at" timestamp with time zone DEFAULT now(),
  "updated_at" timestamp with time zone,
  "first_name" text,
  "last_name"  text,
  CONSTRAINT "profiles_first_name_check" CHECK ((length(TRIM(BOTH FROM first_name)) > 0)),
  CONSTRAINT "profiles_last_name_check" CHECK ((length(TRIM(BOTH FROM last_name)) > 0)),
  CONSTRAINT "profiles_pkey" PRIMARY KEY (id)
);

CREATE TABLE "public"."proposals" (
  "id"         uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "created_at" timestamp with time zone DEFAULT now(),
  "updated_at" timestamp with time zone,
  "round_id"   uuid                     NOT NULL,
  "book_id"    uuid                     NOT NULL,
  "user_id"    uuid                     NOT NULL,
  CONSTRAINT "proposals_pkey" PRIMARY KEY (id),
  CONSTRAINT "proposals_round_id_book_id_key" UNIQUE (round_id, book_id)
);

CREATE TABLE "public"."votes" (
  "id"          uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "created_at"  timestamp with time zone DEFAULT now(),
  "updated_at"  timestamp with time zone,
  "proposal_id" uuid                     NOT NULL,
  "user_id"     uuid                     NOT NULL,
  "points"      smallint                 NOT NULL,
  CONSTRAINT "votes_pkey" PRIMARY KEY (id),
  CONSTRAINT "votes_points_check" CHECK (((points >= 1) AND (points <= 3))),
  CONSTRAINT "votes_user_id_proposal_id_key" UNIQUE (user_id, proposal_id)
);

CREATE TABLE "public"."voting_rounds" (
  "id"         uuid                     NOT NULL DEFAULT gen_random_uuid(),
  "created_at" timestamp with time zone DEFAULT now(),
  "updated_at" timestamp with time zone,
  "period"     date                     NOT NULL,
  "is_open"    boolean                  NOT NULL DEFAULT true,
  CONSTRAINT "voting_rounds_period_key" UNIQUE (period),
  CONSTRAINT "voting_rounds_pkey" PRIMARY KEY (id)
);

CREATE TYPE "public"."user_role" AS ENUM (
  'user',
  'admin'
);

ALTER TABLE "public"."profiles"
  ADD COLUMN "user_role" public.user_role NOT NULL DEFAULT 'user'::public.user_role;

CREATE OR REPLACE FUNCTION public.check_vote_own_proposal()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO 'public'
  AS $function$
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
$function$;

CREATE OR REPLACE FUNCTION public.handle_new_user()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
BEGIN
    INSERT INTO public.profiles(id, first_name, last_name)
        VALUES(NEW.id, NEW.raw_user_meta_data ->> 'first_name', NEW.raw_user_meta_data ->> 'last_name');
    RETURN new;
END;
$function$;

ALTER TABLE "public"."history"
  ADD CONSTRAINT "history_book_id_fkey" FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;

ALTER TABLE "public"."profiles"
  ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;

ALTER TABLE "public"."proposals"
  ADD CONSTRAINT "proposals_book_id_fkey" FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;

ALTER TABLE "public"."proposals"
  ADD CONSTRAINT "proposals_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;

ALTER TABLE "public"."votes"
  ADD CONSTRAINT "votes_proposal_id_fkey" FOREIGN KEY (proposal_id) REFERENCES public.proposals(id) ON DELETE CASCADE;

ALTER TABLE "public"."votes"
  ADD CONSTRAINT "votes_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;

ALTER TABLE "public"."proposals"
  ADD CONSTRAINT "proposals_round_id_fkey" FOREIGN KEY (round_id) REFERENCES public.voting_rounds(id) ON DELETE CASCADE;

CREATE UNIQUE INDEX voting_rounds_one_open ON public.voting_rounds USING btree ((true))
  WHERE (is_open = true);

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

CREATE TRIGGER handle_updated_at_books
  BEFORE UPDATE ON public.books
  FOR EACH ROW
  EXECUTE FUNCTION extensions.moddatetime('updated_at');

CREATE TRIGGER handle_updated_at_history
  BEFORE UPDATE ON public.history
  FOR EACH ROW
  EXECUTE FUNCTION extensions.moddatetime('updated_at');

CREATE TRIGGER handle_updated_at_profiles
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW
  EXECUTE FUNCTION extensions.moddatetime('updated_at');

CREATE TRIGGER handle_updated_at_proposals
  BEFORE UPDATE ON public.proposals
  FOR EACH ROW
  EXECUTE FUNCTION extensions.moddatetime('updated_at');

CREATE TRIGGER before_insert_vote_own_proposal
  BEFORE INSERT ON public.votes
  FOR EACH ROW
  EXECUTE FUNCTION public.check_vote_own_proposal();

CREATE TRIGGER handle_updated_at_votes
  BEFORE UPDATE ON public.votes
  FOR EACH ROW
  EXECUTE FUNCTION extensions.moddatetime('updated_at');

CREATE TRIGGER handle_updated_at_voting_rounds
  BEFORE UPDATE ON public.voting_rounds
  FOR EACH ROW
  EXECUTE FUNCTION extensions.moddatetime('updated_at');

COMMENT ON EXTENSION "moddatetime" IS 'functions for tracking last modification time';

GRANT EXECUTE ON FUNCTION "public"."check_vote_own_proposal"() TO PUBLIC, "anon", "authenticated";

REVOKE ALL ON FUNCTION "public"."check_vote_own_proposal"() FROM "postgres";

GRANT EXECUTE ON FUNCTION "public"."check_vote_own_proposal"() TO "postgres";

GRANT EXECUTE ON FUNCTION "public"."check_vote_own_proposal"() TO "service_role";

GRANT EXECUTE ON FUNCTION "public"."handle_new_user"() TO PUBLIC, "anon", "authenticated";

REVOKE ALL ON FUNCTION "public"."handle_new_user"() FROM "postgres";

GRANT EXECUTE ON FUNCTION "public"."handle_new_user"() TO "postgres";

GRANT EXECUTE ON FUNCTION "public"."handle_new_user"() TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."books" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."books" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."books" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."books" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."history" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."history" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."history" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."history" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."profiles" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."profiles" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."profiles" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."profiles" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."proposals" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."proposals" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."proposals" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."proposals" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."votes" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."votes" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."votes" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."votes" TO "service_role";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."voting_rounds" TO "anon", "authenticated";

REVOKE ALL ON TABLE "public"."voting_rounds" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."voting_rounds" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."voting_rounds" TO "service_role";
