import { integer, pgTable, serial, text, timestamp } from 'drizzle-orm/pg-core';

export const media = pgTable('media', {
  id: serial().primaryKey(),
  filename: text().notNull(),
  originalName: text('original_name').notNull(),
  mimeType: text('mime_type').notNull(),
  sizeBytes: integer('size_bytes').notNull(),
  urlPath: text('url_path').notNull(),
  createdAt: timestamp('created_at', { withTimezone: true }).notNull().defaultNow(),
});

export type Media = typeof media.$inferSelect;
export type NewMedia = typeof media.$inferInsert;
