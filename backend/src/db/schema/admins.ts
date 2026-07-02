import { pgTable, serial, text, timestamp } from 'drizzle-orm/pg-core';

export const admins = pgTable('admins', {
  id: serial().primaryKey(),
  username: text().notNull().unique(),
  passwordHash: text('password_hash').notNull(),
  createdAt: timestamp('created_at', { withTimezone: true }).notNull().defaultNow(),
});

export type Admin = typeof admins.$inferSelect;
export type NewAdmin = typeof admins.$inferInsert;
