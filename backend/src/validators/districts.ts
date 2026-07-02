import { z } from 'zod';
import { optionalText } from './common.js';

export const createDistrictSchema = z.object({
  code: z.string().trim().min(1),
  nameEn: optionalText,
  nameNe: optionalText,
  provinceEn: z.string().trim().min(1),
  latitude: z.number().optional().nullable(),
  longitude: z.number().optional().nullable(),
});

export const updateDistrictSchema = createDistrictSchema.partial();

export type CreateDistrictInput = z.infer<typeof createDistrictSchema>;
export type UpdateDistrictInput = z.infer<typeof updateDistrictSchema>;
