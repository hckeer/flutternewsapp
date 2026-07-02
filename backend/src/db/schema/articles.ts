import { relations } from 'drizzle-orm';
import { index, integer, pgTable, serial, text, timestamp } from 'drizzle-orm/pg-core';
import { media } from './media.js';

export const articles = pgTable(
  'articles',
  {
    id: serial().primaryKey(),
    slug: text().notNull().unique(),
    titleEn: text('title_en'),
    titleNe: text('title_ne'),
    summaryEn: text('summary_en'),
    summaryNe: text('summary_ne'),
    bodyEn: text('body_en'),
    bodyNe: text('body_ne'),
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
  (table) => [index('articles_cover_media_id_idx').on(table.coverMediaId)],
);

export const articlesRelations = relations(articles, ({ one }) => ({
  coverMedia: one(media, {
    fields: [articles.coverMediaId],
    references: [media.id],
  }),
}));

export type Article = typeof articles.$inferSelect;
export type NewArticle = typeof articles.$inferInsert;
