import { relations } from 'drizzle-orm';
import { index, integer, pgTable, serial, text, timestamp } from 'drizzle-orm/pg-core';
import { media } from './media.js';

export const news = pgTable(
  'news',
  {
    id: serial().primaryKey(),
    slug: text().notNull().unique(),
    titleEn: text('title_en'),
    titleNe: text('title_ne'),
    summaryEn: text('summary_en'),
    summaryNe: text('summary_ne'),
    bodyEn: text('body_en'),
    bodyNe: text('body_ne'),
    sourceName: text('source_name'),
    sourceUrl: text('source_url'),
    externalUrl: text('external_url'),
    coverMediaId: integer('cover_media_id').references(() => media.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
    status: text({ enum: ['draft', 'published', 'archived'] })
      .notNull()
      .default('draft'),
    publishedAt: timestamp('published_at', { withTimezone: true }),
    sortOrder: integer('sort_order').notNull().default(0),
    createdAt: timestamp('created_at', { withTimezone: true }).notNull().defaultNow(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .notNull()
      .defaultNow()
      .$onUpdateFn(() => new Date()),
  },
  (table) => [index('news_cover_media_id_idx').on(table.coverMediaId)],
);

export const newsRelations = relations(news, ({ one }) => ({
  coverMedia: one(media, {
    fields: [news.coverMediaId],
    references: [media.id],
  }),
}));

export type News = typeof news.$inferSelect;
export type NewNews = typeof news.$inferInsert;
