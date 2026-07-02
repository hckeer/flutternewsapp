import 'dotenv/config';
import { readMigrationFiles } from 'drizzle-orm/migrator';
import { drizzle } from 'drizzle-orm/node-postgres';
import { migrate } from 'drizzle-orm/node-postgres/migrator';
import { Pool } from 'pg';

const MIGRATIONS_FOLDER = './drizzle';

async function baselineExistingSchema(pool: Pool) {
  const client = await pool.connect();
  try {
    const { rows } = await client.query<{ exists: boolean }>(`
      SELECT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'public' AND table_name = 'admins'
      ) AS exists
    `);
    if (!rows[0]?.exists) return;

    await client.query(`
      CREATE TABLE IF NOT EXISTS "__drizzle_migrations" (
        id SERIAL PRIMARY KEY,
        hash text NOT NULL,
        created_at bigint
      )
    `);

    const migrations = readMigrationFiles({ migrationsFolder: MIGRATIONS_FOLDER });
    const { rows: applied } = await client.query<{ hash: string }>(
      `SELECT hash FROM "__drizzle_migrations"`,
    );
    const appliedHashes = new Set(applied.map((row) => row.hash));

    let baselined = 0;
    for (const migration of migrations) {
      if (appliedHashes.has(migration.hash)) continue;
      await client.query(
        `INSERT INTO "__drizzle_migrations" (hash, created_at) VALUES ($1, $2)`,
        [migration.hash, migration.folderMillis],
      );
      baselined++;
    }

    if (baselined > 0) {
      console.log(`Baselined ${baselined} migration(s) for existing schema`);
    }
  } finally {
    client.release();
  }
}

async function runMigrations() {
  const databaseUrl = process.env.DATABASE_URL;
  if (!databaseUrl) {
    throw new Error('DATABASE_URL is not set');
  }

  const pool = new Pool({
    connectionString: databaseUrl,
    ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : undefined,
  });

  try {
    await baselineExistingSchema(pool);
    const db = drizzle(pool);
    await migrate(db, { migrationsFolder: MIGRATIONS_FOLDER });
    console.log('Database migrations applied');
  } finally {
    await pool.end();
  }
}

runMigrations().catch((err) => {
  console.error('Migration failed:', err);
  process.exit(1);
});
