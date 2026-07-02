import Database from 'better-sqlite3';
import { sql } from 'drizzle-orm';
import { db } from './client.js';
import { env } from '../config/env.js';
import { admins } from './schema/admins.js';
import { articles } from './schema/articles.js';
import { contacts } from './schema/contacts.js';
import { districts } from './schema/districts.js';
import { media } from './schema/media.js';
import { news } from './schema/news.js';
import { statistics } from './schema/statistics.js';
import { uploadMediaObject } from '../services/storage.js';
import { readFileSync } from 'node:fs';
import path from 'node:path';

type LocalAdmin = {
  id: number;
  username: string;
  password_hash: string;
  created_at: number;
};

type LocalDistrict = {
  id: number;
  code: string;
  name_en: string | null;
  name_ne: string | null;
  province_en: string;
  latitude: number | null;
  longitude: number | null;
};

type LocalMedia = {
  id: number;
  filename: string;
  original_name: string;
  mime_type: string;
  size_bytes: number;
  url_path: string;
  created_at: number;
};

type LocalArticle = {
  id: number;
  slug: string;
  title_en: string | null;
  title_ne: string | null;
  summary_en: string | null;
  summary_ne: string | null;
  body_en: string | null;
  body_ne: string | null;
  cover_media_id: number | null;
  status: 'draft' | 'published' | 'archived';
  published_at: number | null;
  sort_order: number;
  created_at: number;
  updated_at: number;
};

type LocalNews = {
  id: number;
  slug: string;
  title_en: string | null;
  title_ne: string | null;
  summary_en: string | null;
  summary_ne: string | null;
  body_en: string | null;
  body_ne: string | null;
  source_name: string | null;
  source_url: string | null;
  external_url: string | null;
  cover_media_id: number | null;
  status: 'draft' | 'published' | 'archived';
  published_at: number | null;
  sort_order: number;
  created_at: number;
  updated_at: number;
};

type LocalStatistic = {
  id: number;
  district_id: number;
  season_year: number;
  week_number: number | null;
  case_count: number;
  reported_at: string;
  notes_en: string | null;
  notes_ne: string | null;
  created_at: number;
  updated_at: number;
};

type LocalContact = {
  id: number;
  name_en: string | null;
  name_ne: string | null;
  phone: string;
  district_id: number | null;
  contact_type: 'hotline' | 'hospital' | 'clinic' | 'other';
  is_active: number;
  sort_order: number;
};

function toDate(value: number | null) {
  return value == null ? null : new Date(value);
}

async function resetSequence(tableName: string, idColumn = 'id') {
  await db.execute(sql.raw(`
    SELECT setval(
      pg_get_serial_sequence('${tableName}', '${idColumn}'),
      COALESCE((SELECT MAX(${idColumn}) FROM ${tableName}), 1),
      COALESCE((SELECT MAX(${idColumn}) FROM ${tableName}), 0) > 0
    );
  `));
}

async function importData() {
  const sqlite = new Database(env.LOCAL_SQLITE_PATH, { readonly: true });

  const localAdmins = sqlite.prepare('SELECT * FROM admins').all() as LocalAdmin[];
  const localDistricts = sqlite.prepare('SELECT * FROM districts').all() as LocalDistrict[];
  const localMedia = sqlite.prepare('SELECT * FROM media').all() as LocalMedia[];
  const localArticles = sqlite.prepare('SELECT * FROM articles').all() as LocalArticle[];
  const localNews = sqlite.prepare('SELECT * FROM news').all() as LocalNews[];
  const localStatistics = sqlite
    .prepare('SELECT * FROM statistics')
    .all() as LocalStatistic[];
  const localContacts = sqlite.prepare('SELECT * FROM contacts').all() as LocalContact[];

  for (const row of localAdmins) {
    await db
      .insert(admins)
      .values({
        id: row.id,
        username: row.username,
        passwordHash: row.password_hash,
        createdAt: new Date(row.created_at),
      })
      .onConflictDoUpdate({
        target: admins.id,
        set: {
          username: row.username,
          passwordHash: row.password_hash,
          createdAt: new Date(row.created_at),
        },
      });
  }

  for (const row of localDistricts) {
    await db
      .insert(districts)
      .values({
        id: row.id,
        code: row.code,
        nameEn: row.name_en,
        nameNe: row.name_ne,
        provinceEn: row.province_en,
        latitude: row.latitude,
        longitude: row.longitude,
      })
      .onConflictDoUpdate({
        target: districts.id,
        set: {
          code: row.code,
          nameEn: row.name_en,
          nameNe: row.name_ne,
          provinceEn: row.province_en,
          latitude: row.latitude,
          longitude: row.longitude,
        },
      });
  }

  for (const row of localMedia) {
    const localFilePath = path.join(env.LOCAL_UPLOADS_DIR, row.filename);
    const publicUrl = await uploadMediaObject({
      objectPath: row.filename,
      content: readFileSync(localFilePath),
      contentType: row.mime_type,
    });

    await db
      .insert(media)
      .values({
        id: row.id,
        filename: row.filename,
        originalName: row.original_name,
        mimeType: row.mime_type,
        sizeBytes: row.size_bytes,
        urlPath: publicUrl,
        createdAt: new Date(row.created_at),
      })
      .onConflictDoUpdate({
        target: media.id,
        set: {
          filename: row.filename,
          originalName: row.original_name,
          mimeType: row.mime_type,
          sizeBytes: row.size_bytes,
          urlPath: publicUrl,
          createdAt: new Date(row.created_at),
        },
      });
  }

  for (const row of localArticles) {
    await db
      .insert(articles)
      .values({
        id: row.id,
        slug: row.slug,
        titleEn: row.title_en,
        titleNe: row.title_ne,
        summaryEn: row.summary_en,
        summaryNe: row.summary_ne,
        bodyEn: row.body_en,
        bodyNe: row.body_ne,
        coverMediaId: row.cover_media_id,
        status: row.status,
        publishedAt: toDate(row.published_at),
        sortOrder: row.sort_order,
        createdAt: new Date(row.created_at),
        updatedAt: new Date(row.updated_at),
      })
      .onConflictDoUpdate({
        target: articles.id,
        set: {
          slug: row.slug,
          titleEn: row.title_en,
          titleNe: row.title_ne,
          summaryEn: row.summary_en,
          summaryNe: row.summary_ne,
          bodyEn: row.body_en,
          bodyNe: row.body_ne,
          coverMediaId: row.cover_media_id,
          status: row.status,
          publishedAt: toDate(row.published_at),
          sortOrder: row.sort_order,
          createdAt: new Date(row.created_at),
          updatedAt: new Date(row.updated_at),
        },
      });
  }

  for (const row of localNews) {
    await db
      .insert(news)
      .values({
        id: row.id,
        slug: row.slug,
        titleEn: row.title_en,
        titleNe: row.title_ne,
        summaryEn: row.summary_en,
        summaryNe: row.summary_ne,
        bodyEn: row.body_en,
        bodyNe: row.body_ne,
        sourceName: row.source_name,
        sourceUrl: row.source_url,
        externalUrl: row.external_url,
        coverMediaId: row.cover_media_id,
        status: row.status,
        publishedAt: toDate(row.published_at),
        sortOrder: row.sort_order,
        createdAt: new Date(row.created_at),
        updatedAt: new Date(row.updated_at),
      })
      .onConflictDoUpdate({
        target: news.id,
        set: {
          slug: row.slug,
          titleEn: row.title_en,
          titleNe: row.title_ne,
          summaryEn: row.summary_en,
          summaryNe: row.summary_ne,
          bodyEn: row.body_en,
          bodyNe: row.body_ne,
          sourceName: row.source_name,
          sourceUrl: row.source_url,
          externalUrl: row.external_url,
          coverMediaId: row.cover_media_id,
          status: row.status,
          publishedAt: toDate(row.published_at),
          sortOrder: row.sort_order,
          createdAt: new Date(row.created_at),
          updatedAt: new Date(row.updated_at),
        },
      });
  }

  for (const row of localStatistics) {
    await db
      .insert(statistics)
      .values({
        id: row.id,
        districtId: row.district_id,
        seasonYear: row.season_year,
        weekNumber: row.week_number,
        caseCount: row.case_count,
        reportedAt: row.reported_at,
        notesEn: row.notes_en,
        notesNe: row.notes_ne,
        createdAt: new Date(row.created_at),
        updatedAt: new Date(row.updated_at),
      })
      .onConflictDoUpdate({
        target: statistics.id,
        set: {
          districtId: row.district_id,
          seasonYear: row.season_year,
          weekNumber: row.week_number,
          caseCount: row.case_count,
          reportedAt: row.reported_at,
          notesEn: row.notes_en,
          notesNe: row.notes_ne,
          createdAt: new Date(row.created_at),
          updatedAt: new Date(row.updated_at),
        },
      });
  }

  for (const row of localContacts) {
    await db
      .insert(contacts)
      .values({
        id: row.id,
        nameEn: row.name_en,
        nameNe: row.name_ne,
        phone: row.phone,
        districtId: row.district_id,
        contactType: row.contact_type,
        isActive: row.is_active === 1,
        sortOrder: row.sort_order,
      })
      .onConflictDoUpdate({
        target: contacts.id,
        set: {
          nameEn: row.name_en,
          nameNe: row.name_ne,
          phone: row.phone,
          districtId: row.district_id,
          contactType: row.contact_type,
          isActive: row.is_active === 1,
          sortOrder: row.sort_order,
        },
      });
  }

  await resetSequence('admins');
  await resetSequence('districts');
  await resetSequence('media');
  await resetSequence('articles');
  await resetSequence('news');
  await resetSequence('statistics');
  await resetSequence('contacts');

  sqlite.close();
  console.log('Local SQLite data imported into Postgres and Supabase Storage');
}

importData().catch((err) => {
  console.error('Import failed:', err);
  process.exit(1);
});
