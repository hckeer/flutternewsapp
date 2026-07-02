import { relations } from 'drizzle-orm';
import { index, integer, pgTable, serial, text, timestamp } from 'drizzle-orm/pg-core';
import { districts } from './districts.js';

export const statistics = pgTable(
  'statistics',
  {
    id: serial().primaryKey(),
    districtId: integer('district_id')
      .notNull()
      .references(() => districts.id, { onDelete: 'cascade', onUpdate: 'cascade' }),
    seasonYear: integer('season_year').notNull(),
    weekNumber: integer('week_number'),
    caseCount: integer('case_count').notNull(),
    reportedAt: text('reported_at').notNull(),
    notesEn: text('notes_en'),
    notesNe: text('notes_ne'),
    createdAt: timestamp('created_at', { withTimezone: true }).notNull().defaultNow(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .notNull()
      .defaultNow()
      .$onUpdateFn(() => new Date()),
  },
  (table) => [index('statistics_district_id_idx').on(table.districtId)],
);

export const statisticsRelations = relations(statistics, ({ one }) => ({
  district: one(districts, {
    fields: [statistics.districtId],
    references: [districts.id],
  }),
}));

export type Statistic = typeof statistics.$inferSelect;
export type NewStatistic = typeof statistics.$inferInsert;
