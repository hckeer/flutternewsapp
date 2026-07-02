CREATE TABLE "admins" (
	"id" serial PRIMARY KEY NOT NULL,
	"username" text NOT NULL,
	"password_hash" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "admins_username_unique" UNIQUE("username")
);
--> statement-breakpoint
CREATE TABLE "articles" (
	"id" serial PRIMARY KEY NOT NULL,
	"slug" text NOT NULL,
	"title_en" text,
	"title_ne" text,
	"summary_en" text,
	"summary_ne" text,
	"body_en" text,
	"body_ne" text,
	"cover_media_id" integer,
	"status" text DEFAULT 'draft' NOT NULL,
	"published_at" timestamp with time zone,
	"sort_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "articles_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE "contacts" (
	"id" serial PRIMARY KEY NOT NULL,
	"name_en" text,
	"name_ne" text,
	"phone" text NOT NULL,
	"district_id" integer,
	"contact_type" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"sort_order" integer DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE "districts" (
	"id" serial PRIMARY KEY NOT NULL,
	"code" text NOT NULL,
	"name_en" text,
	"name_ne" text,
	"province_en" text NOT NULL,
	"latitude" double precision,
	"longitude" double precision,
	CONSTRAINT "districts_code_unique" UNIQUE("code")
);
--> statement-breakpoint
CREATE TABLE "media" (
	"id" serial PRIMARY KEY NOT NULL,
	"filename" text NOT NULL,
	"original_name" text NOT NULL,
	"mime_type" text NOT NULL,
	"size_bytes" integer NOT NULL,
	"url_path" text NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "news" (
	"id" serial PRIMARY KEY NOT NULL,
	"slug" text NOT NULL,
	"title_en" text,
	"title_ne" text,
	"summary_en" text,
	"summary_ne" text,
	"body_en" text,
	"body_ne" text,
	"source_name" text,
	"source_url" text,
	"external_url" text,
	"cover_media_id" integer,
	"status" text DEFAULT 'draft' NOT NULL,
	"published_at" timestamp with time zone,
	"sort_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "news_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE "statistics" (
	"id" serial PRIMARY KEY NOT NULL,
	"district_id" integer NOT NULL,
	"season_year" integer NOT NULL,
	"week_number" integer,
	"case_count" integer NOT NULL,
	"reported_at" text NOT NULL,
	"notes_en" text,
	"notes_ne" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "articles" ADD CONSTRAINT "articles_cover_media_id_media_id_fk" FOREIGN KEY ("cover_media_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE "contacts" ADD CONSTRAINT "contacts_district_id_districts_id_fk" FOREIGN KEY ("district_id") REFERENCES "public"."districts"("id") ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE "news" ADD CONSTRAINT "news_cover_media_id_media_id_fk" FOREIGN KEY ("cover_media_id") REFERENCES "public"."media"("id") ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE "statistics" ADD CONSTRAINT "statistics_district_id_districts_id_fk" FOREIGN KEY ("district_id") REFERENCES "public"."districts"("id") ON DELETE cascade ON UPDATE cascade;--> statement-breakpoint
CREATE INDEX "articles_cover_media_id_idx" ON "articles" USING btree ("cover_media_id");--> statement-breakpoint
CREATE INDEX "contacts_district_id_idx" ON "contacts" USING btree ("district_id");--> statement-breakpoint
CREATE INDEX "districts_code_idx" ON "districts" USING btree ("code");--> statement-breakpoint
CREATE INDEX "news_cover_media_id_idx" ON "news" USING btree ("cover_media_id");--> statement-breakpoint
CREATE INDEX "statistics_district_id_idx" ON "statistics" USING btree ("district_id");