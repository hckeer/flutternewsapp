import { z } from 'zod';
import { contactTypeEnum, optionalText, refineActiveContact } from './common.js';

const contactFields = {
  nameEn: optionalText,
  nameNe: optionalText,
  phone: z.string().trim().min(1),
  districtId: z.number().int().positive().optional().nullable(),
  contactType: contactTypeEnum,
  isActive: z.boolean().default(true),
  sortOrder: z.number().int().default(0),
};

export const createContactSchema = z
  .object(contactFields)
  .superRefine(refineActiveContact);

export const updateContactSchema = z
  .object({
    nameEn: optionalText,
    nameNe: optionalText,
    phone: z.string().trim().min(1).optional(),
    districtId: z.number().int().positive().optional().nullable(),
    contactType: contactTypeEnum.optional(),
    isActive: z.boolean().optional(),
    sortOrder: z.number().int().optional(),
  })
  .superRefine((data, ctx) => {
    if (data.isActive === true) {
      refineActiveContact(
        {
          isActive: true,
          nameEn: data.nameEn,
          nameNe: data.nameNe,
        },
        ctx,
      );
    }
  });

export type CreateContactInput = z.infer<typeof createContactSchema>;
export type UpdateContactInput = z.infer<typeof updateContactSchema>;
