import { relations } from 'drizzle-orm';
import { doublePrecision, index, pgTable, serial, text } from 'drizzle-orm/pg-core';
import { contacts } from './contacts.js';
import { statistics } from './statistics.js';

export const districts = pgTable(
  'districts',
  {
    id: serial().primaryKey(),
    code: text().notNull().unique(),
    nameEn: text('name_en'),
    nameNe: text('name_ne'),
    provinceEn: text('province_en').notNull(),
    latitude: doublePrecision(),
    longitude: doublePrecision(),
  },
  (table) => [index('districts_code_idx').on(table.code)],
);

export const districtsRelations = relations(districts, ({ many }) => ({
  statistics: many(statistics),
  contacts: many(contacts),
}));

export type District = typeof districts.$inferSelect;
export type NewDistrict = typeof districts.$inferInsert;
