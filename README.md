# Dengue Nepal

Flutter (Android) + Express monorepo for dengue awareness in Nepal.

## Structure

```
dengue-nepal/
├── backend/   # Express REST API + Drizzle ORM + Postgres/Supabase Storage
└── mobile/    # Flutter Android app
```

## Backend

```bash
cd backend
cp .env.example .env
npm install
npm run db:generate && npm run db:migrate && npm run db:seed
npm run dev
```

Verify:

```bash
curl http://localhost:3000/health
curl http://localhost:3000/api/public/articles
curl -X POST http://localhost:3000/api/auth/login \
  -H 'Content-Type: application/json' \
  -d '{"username":"admin","password":"admin"}'
```

Default admin: `admin` / `admin` (dev only).

### Required environment variables

```bash
PORT=3000
NODE_ENV=development
DATABASE_URL=postgresql://postgres:postgres@127.0.0.1:5432/dengue_nepal
JWT_SECRET=change-me-in-production-min-32-chars-long
JWT_EXPIRES_IN=24h
ADMIN_USERNAME=admin
ADMIN_PASSWORD=admin
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
SUPABASE_STORAGE_BUCKET=media
LOCAL_SQLITE_PATH=./data.db
LOCAL_UPLOADS_DIR=./uploads
```

### Supabase setup

1. Create a Supabase project.
2. Create a storage bucket named `media`.
3. Mark the bucket as `public`.
4. Copy:
   - `Project URL` -> `SUPABASE_URL`
   - `service_role` key -> `SUPABASE_SERVICE_ROLE_KEY`
   - `Connection string` -> `DATABASE_URL`

The backend uploads article/news media to Supabase Storage and saves the public URL in the `media` table.

### Migrations and seeding

```bash
cd backend
npm run db:migrate
npm run db:seed
```

### Import current local project data into production

If you already have local SQLite content and files in `backend/uploads/`, import them into Postgres + Supabase Storage:

```bash
cd backend
npm run db:import:local
```

### Admin API (JWT required)

All routes under `/api/admin/*` need `Authorization: Bearer <token>`.

| Resource | Endpoints |
|---|---|
| articles, news, statistics, districts, contacts | `GET/POST` list/create, `GET/PUT/DELETE /:id` |
| media | `GET` list, `GET /:id`, `POST /upload` (field: `file`), `DELETE /:id` |

Publish rules (articles/news): at least one title + body language; `publishedAt` auto-set on create if omitted. Uploaded media is now stored in Supabase Storage, not on the local filesystem.

```bash
TOKEN=$(curl -s -X POST http://localhost:3000/api/auth/login \
  -H 'Content-Type: application/json' \
  -d '{"username":"admin","password":"admin"}' \
  | jq -r '.data.token')

curl -H "Authorization: Bearer $TOKEN" http://localhost:3000/api/admin/articles
```

## Mobile

Flutter SDK: `~/flutter/bin/flutter` (add to PATH if needed).

**Wireless debugging** — point the app at your machine's LAN IP:

```bash
cd mobile
flutter run --dart-define=API_BASE_URL=http://192.168.x.x:3000/api
```

### Production Android build

```bash
cd mobile
~/flutter/bin/flutter build apk \
  --release \
  --dart-define=API_BASE_URL=https://your-render-service.onrender.com/api
```

## Free production deployment

Recommended free stack:
- `Render` free web service for the backend
- `Supabase Postgres` for relational data
- `Supabase Storage` for images and PDFs

### Render deploy

This repo includes [`render.yaml`](render.yaml).

Steps:
1. Push `dengue-nepal/` to GitHub.
2. In Render, create a new Blueprint or Web Service from the repo.
3. Set the root to the repo root so Render can read `render.yaml`.
4. Fill the secret env vars in Render:
   - `DATABASE_URL`
   - `JWT_SECRET`
   - `ADMIN_USERNAME`
   - `ADMIN_PASSWORD`
   - `SUPABASE_URL`
   - `SUPABASE_SERVICE_ROLE_KEY`
5. Deploy.
6. After the first deploy, run:
   - `npm run db:migrate`
   - `npm run db:seed`
   - `npm run db:import:local` if you are moving existing local data

### Caveats

- Render free web services sleep after inactivity, so the first request may be slow.
- Supabase free projects can pause after long inactivity; open the app or dashboard periodically during the project year.
- Supabase free limits are enough for a small final-year project, but uploaded media should stay modest in size.

## Skills used

See `plan.md` Section 2. Backend scaffolded with `drizzle-sqlite-scaffold`, `express-rest-api`, `jwt-security`. Flutter structure follows `flutter-apply-architecture-best-practices`, `go_router`, `flutter-use-http-package`.

## Production verification checklist

- `GET /health` responds from the Render URL
- admin login works
- article/news create and edit works
- optional cover upload works
- public article/news screens show uploaded cover images
- PDFs open from the public URL
- production Android build uses the Render API URL only
