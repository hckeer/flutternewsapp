import { eq } from 'drizzle-orm';
import type { PgTableWithColumns } from 'drizzle-orm/pg-core';
import { db } from '../db/client.js';
import { districts } from '../db/schema/districts.js';
import { media } from '../db/schema/media.js';
import { ApiError } from '../middleware/errorHandler.js';

export async function assertDistrictExists(districtId: number) {
  const [row] = await db
    .select({ id: districts.id })
    .from(districts)
    .where(eq(districts.id, districtId))
    .limit(1);
  if (!row) {
    throw new ApiError(400, 'INVALID_DISTRICT', `District ${districtId} not found`);
  }
}

export async function assertMediaExists(mediaId: number | null | undefined) {
  if (mediaId == null) return;
  const [row] = await db
    .select({ id: media.id })
    .from(media)
    .where(eq(media.id, mediaId))
    .limit(1);
  if (!row) {
    throw new ApiError(400, 'INVALID_MEDIA', `Media ${mediaId} not found`);
  }
}

export function normalizePublishedAt(
  status: string,
  publishedAt: Date | null | undefined,
): Date | null {
  if (status === 'published') {
    return publishedAt ?? new Date();
  }
  return publishedAt ?? null;
}

export function isUniqueViolation(err: unknown): boolean {
  return (
    err instanceof Error &&
    'code' in err &&
    err.code === '23505'
  );
}

export async function getById<T extends PgTableWithColumns<any>>(table: T, id: number) {
  const typedTable = table as any;
  const [row] = await db
    .select()
    .from(typedTable)
    .where(eq(typedTable.id, id))
    .limit(1);
  return (row ?? null) as T['$inferSelect'] | null;
}
