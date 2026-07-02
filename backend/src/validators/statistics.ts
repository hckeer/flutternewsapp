import { z } from 'zod';
import { optionalText } from './common.js';

export const createStatisticSchema = z.object({
  districtId: z.number().int().positive(),
  seasonYear: z.number().int(),
  weekNumber: z.number().int().optional().nullable(),
  caseCount: z.number().int().min(0),
  reportedAt: z.string().trim().min(1),
  notesEn: optionalText,
  notesNe: optionalText,
});

export const updateStatisticSchema = createStatisticSchema.partial();

export type CreateStatisticInput = z.infer<typeof createStatisticSchema>;
export type UpdateStatisticInput = z.infer<typeof updateStatisticSchema>;
