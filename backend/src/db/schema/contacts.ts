import { relations } from 'drizzle-orm';
import { boolean, index, integer, pgTable, serial, text } from 'drizzle-orm/pg-core';
import { districts } from './districts.js';

export const contacts = pgTable(
  'contacts',
  {
    id: serial().primaryKey(),
    nameEn: text('name_en'),
    nameNe: text('name_ne'),
    phone: text().notNull(),
    districtId: integer('district_id').references(() => districts.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
    contactType: text('contact_type', {
      enum: ['hotline', 'hospital', 'clinic', 'other'],
    }).notNull(),
    isActive: boolean('is_active').notNull().default(true),
    sortOrder: integer('sort_order').notNull().default(0),
  },
  (table) => [index('contacts_district_id_idx').on(table.districtId)],
);

export const contactsRelations = relations(contacts, ({ one }) => ({
  district: one(districts, {
    fields: [contacts.districtId],
    references: [districts.id],
  }),
}));

export type Contact = typeof contacts.$inferSelect;
export type NewContact = typeof contacts.$inferInsert;
