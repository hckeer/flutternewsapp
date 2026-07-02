import { z } from 'zod';

export const idParamSchema = z.object({
  id: z.coerce.number().int().positive(),
});

export const statusEnum = z.enum(['draft', 'published', 'archived']);

export const contactTypeEnum = z.enum(['hotline', 'hospital', 'clinic', 'other']);

const optionalText = z.string().trim().optional().nullable();

export function hasAtLeastOneLanguage(a?: string | null, b?: string | null): boolean {
  return Boolean(a?.trim() || b?.trim());
}

export function parsePublishedAt(value: unknown): Date | null | undefined {
  if (value === null || value === undefined) return value as null | undefined;
  if (value instanceof Date) return value;
  if (typeof value === 'number') return new Date(value);
  if (typeof value === 'string') {
    const d = new Date(value);
    if (Number.isNaN(d.getTime())) return undefined;
    return d;
  }
  return undefined;
}

export const publishedAtField = z
  .union([z.string(), z.number(), z.date()])
  .optional()
  .nullable()
  .transform((v) => (v == null ? null : parsePublishedAt(v) ?? null));

export function refinePublishableContent(
  data: {
    status: string;
    titleEn?: string | null;
    titleNe?: string | null;
    bodyEn?: string | null;
    bodyNe?: string | null;
    publishedAt?: Date | null;
  },
  ctx: z.RefinementCtx,
) {
  if (data.status !== 'published') return;

  if (!hasAtLeastOneLanguage(data.titleEn, data.titleNe)) {
    ctx.addIssue({
      code: 'custom',
      message: 'At least one title (English or Nepali) is required to publish',
      path: ['titleEn'],
    });
  }
  if (!hasAtLeastOneLanguage(data.bodyEn, data.bodyNe)) {
    ctx.addIssue({
      code: 'custom',
      message: 'At least one body (English or Nepali) is required to publish',
      path: ['bodyEn'],
    });
  }
  if (!data.publishedAt) {
    ctx.addIssue({
      code: 'custom',
      message: 'publishedAt is required when status is published',
      path: ['publishedAt'],
    });
  }
}

export function refineActiveContact(
  data: { isActive: boolean; nameEn?: string | null; nameNe?: string | null },
  ctx: z.RefinementCtx,
) {
  if (!data.isActive) return;
  if (!hasAtLeastOneLanguage(data.nameEn, data.nameNe)) {
    ctx.addIssue({
      code: 'custom',
      message: 'At least one name (English or Nepali) is required for active contacts',
      path: ['nameEn'],
    });
  }
}

export { optionalText };
