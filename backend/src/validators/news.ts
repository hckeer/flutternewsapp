import { z } from 'zod';
import {
  optionalText,
  publishedAtField,
  refinePublishableContent,
  statusEnum,
} from './common.js';

const newsFields = {
  slug: z.string().trim().min(1),
  titleEn: optionalText,
  titleNe: optionalText,
  summaryEn: optionalText,
  summaryNe: optionalText,
  bodyEn: optionalText,
  bodyNe: optionalText,
  sourceName: optionalText,
  sourceUrl: optionalText,
  externalUrl: optionalText,
  coverMediaId: z.number().int().positive().optional().nullable(),
  status: statusEnum.default('draft'),
  publishedAt: publishedAtField,
  sortOrder: z.number().int().default(0),
};

export const createNewsSchema = z
  .object(newsFields)
  .transform((data) => {
    if (data.status === 'published' && !data.publishedAt) {
      return { ...data, publishedAt: new Date() };
    }
    return data;
  })
  .superRefine(refinePublishableContent);

export const updateNewsSchema = z
  .object({
    slug: z.string().trim().min(1).optional(),
    titleEn: optionalText,
    titleNe: optionalText,
    summaryEn: optionalText,
    summaryNe: optionalText,
    bodyEn: optionalText,
    bodyNe: optionalText,
    sourceName: optionalText,
    sourceUrl: optionalText,
    externalUrl: optionalText,
    coverMediaId: z.number().int().positive().optional().nullable(),
    status: statusEnum.optional(),
    publishedAt: publishedAtField,
    sortOrder: z.number().int().optional(),
  })
  .superRefine((data, ctx) => {
    if (data.status === 'published') {
      refinePublishableContent(
        {
          status: data.status,
          titleEn: data.titleEn,
          titleNe: data.titleNe,
          bodyEn: data.bodyEn,
          bodyNe: data.bodyNe,
          publishedAt: data.publishedAt ?? undefined,
        },
        ctx,
      );
    }
  });

export type CreateNewsInput = z.infer<typeof createNewsSchema>;
export type UpdateNewsInput = z.infer<typeof updateNewsSchema>;
