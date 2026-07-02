import 'dotenv/config';
import { readMigrationFiles } from 'drizzle-orm/migrator';
import { drizzle } from 'drizzle-orm/node-postgres';
import { migrate } from 'drizzle-orm/node-postgres/migrator';
import { Pool } from 'pg';

const MIGRATIONS_FOLDER = './drizzle';
const MIGRATIONS_SCHEMA = 'drizzle';
const MIGRATIONS_TABLE = '__drizzle_migrations';

async function schemaAlreadyExists(pool: Pool): Promise<boolean> {
  const client = await pool.connect();
  try {
    const { rows } = await client.query<{ exists: boolean }>(`
      SELECT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_schema = 'public' AND table_name = 'admins'
      ) AS exists
    `);
    return rows[0]?.exists ?? false;
  } finally {
    client.release();
  }
}

async function baselineExistingSchema(pool: Pool) {
  const client = await pool.connect();
  try {
    await client.query(`CREATE SCHEMA IF NOT EXISTS ${MIGRATIONS_SCHEMA}`);
    await client.query(`
      CREATE TABLE IF NOT EXISTS ${MIGRATIONS_SCHEMA}."${MIGRATIONS_TABLE}" (
        id SERIAL PRIMARY KEY,
        hash text NOT NULL,
        created_at bigint
      )
    `);

    const migrations = readMigrationFiles({ migrationsFolder: MIGRATIONS_FOLDER });
    const { rows: applied } = await client.query<{ hash: string }>(
      `SELECT hash FROM ${MIGRATIONS_SCHEMA}."${MIGRATIONS_TABLE}"`,
    );
    const appliedHashes = new Set(applied.map((row) => row.hash));

    let baselined = 0;
    for (const migration of migrations) {
      if (appliedHashes.has(migration.hash)) continue;
      await client.query(
        `INSERT INTO ${MIGRATIONS_SCHEMA}."${MIGRATIONS_TABLE}" (hash, created_at) VALUES ($1, $2)`,
        [migration.hash, migration.folderMillis],
      );
      baselined++;
    }

    if (baselined > 0) {
      console.log(`Baselined ${baselined} migration(s) in ${MIGRATIONS_SCHEMA}.${MIGRATIONS_TABLE}`);
    }
  } finally {
    client.release();
  }
}

async function migrationsAreCurrent(pool: Pool): Promise<boolean> {
  const client = await pool.connect();
  try {
    const migrations = readMigrationFiles({ migrationsFolder: MIGRATIONS_FOLDER });
    const latestMigrationMillis = Math.max(...migrations.map((m) => m.folderMillis));

    const { rows } = await client.query<{ created_at: string }>(`
      SELECT created_at
      FROM ${MIGRATIONS_SCHEMA}."${MIGRATIONS_TABLE}"
      ORDER BY created_at DESC
      LIMIT 1
    `);

    if (rows.length === 0) return false;
    return Number(rows[0].created_at) >= latestMigrationMillis;
  } catch {
    return false;
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
    if (await schemaAlreadyExists(pool)) {
      await baselineExistingSchema(pool);
      if (await migrationsAreCurrent(pool)) {
        console.log('Existing schema detected; migrations already current');
        return;
      }
    }

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
