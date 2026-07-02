import { drizzle } from 'drizzle-orm/node-postgres';
import { migrate } from 'drizzle-orm/node-postgres/migrator';
import { Pool } from 'pg';
import { env } from '../config/env.js';
import * as schema from './schema/index.js';

declare global {
  // eslint-disable-next-line no-var
  var __pgPool__: Pool | undefined;
}

function initPool() {
  return new Pool({
    connectionString: env.DATABASE_URL,
    ssl: env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : undefined,
  });
}

const pool = globalThis.__pgPool__ ?? initPool();
if (env.NODE_ENV !== 'production') {
  globalThis.__pgPool__ = pool;
}

export const db = drizzle(pool, { schema });
export const rawPool = pool;

migrate(db, { migrationsFolder: './drizzle' });
