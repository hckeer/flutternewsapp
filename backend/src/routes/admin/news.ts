import { desc, eq } from 'drizzle-orm';
import { Router } from 'express';
import { db } from '../../db/client.js';
import { news } from '../../db/schema/news.js';
import { ApiError } from '../../middleware/errorHandler.js';
import { validateBody } from '../../middleware/validate.js';
import {
  assertMediaExists,
  getById,
  isUniqueViolation,
  normalizePublishedAt,
} from '../../services/refs.js';
import {
  createNewsSchema,
  updateNewsSchema,
  type CreateNewsInput,
  type UpdateNewsInput,
} from '../../validators/news.js';
import { handleRoute, parseIdParam, sendNotFound } from './helpers.js';

export const adminNewsRouter = Router();

adminNewsRouter.get('/', async (_req, res, next) => {
  await handleRoute(res, next, async () => {
    const rows = await db.select().from(news).orderBy(desc(news.updatedAt));
    res.json({ data: rows, error: null });
  });
});

adminNewsRouter.get('/:id', async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const row = await getById(news, id);
    if (!row) {
      sendNotFound(res, 'News item');
      return;
    }
    res.json({ data: row, error: null });
  });
});

adminNewsRouter.post('/', validateBody(createNewsSchema), async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const body = req.body as CreateNewsInput;
    await assertMediaExists(body.coverMediaId);
    const publishedAt = normalizePublishedAt(body.status, body.publishedAt);

    try {
      const [row] = await db
        .insert(news)
        .values({ ...body, publishedAt })
        .returning();
      res.status(201).json({ data: row, error: null });
    } catch (err) {
      if (isUniqueViolation(err)) {
        throw new ApiError(409, 'DUPLICATE_SLUG', 'News slug already exists');
      }
      throw err;
    }
  });
});

adminNewsRouter.put('/:id', validateBody(updateNewsSchema), async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const existing = await getById(news, id);
    if (!existing) {
      sendNotFound(res, 'News item');
      return;
    }

    const body = req.body as UpdateNewsInput;
    await assertMediaExists(body.coverMediaId);

    const status = body.status ?? existing.status;
    const publishedAt = normalizePublishedAt(
      status,
      body.publishedAt !== undefined ? body.publishedAt : existing.publishedAt,
    );

    if (status === 'published') {
      const result = updateNewsSchema.safeParse({
        ...body,
        status,
        publishedAt,
        titleEn: body.titleEn !== undefined ? body.titleEn : existing.titleEn,
        titleNe: body.titleNe !== undefined ? body.titleNe : existing.titleNe,
        bodyEn: body.bodyEn !== undefined ? body.bodyEn : existing.bodyEn,
        bodyNe: body.bodyNe !== undefined ? body.bodyNe : existing.bodyNe,
      });
      if (!result.success) {
        throw new ApiError(
          400,
          'VALIDATION_ERROR',
          result.error.issues.map((i) => i.message).join('; '),
        );
      }
    }

    try {
      const [row] = await db
        .update(news)
        .set({ ...body, status, publishedAt })
        .where(eq(news.id, id))
        .returning();
      res.json({ data: row, error: null });
    } catch (err) {
      if (isUniqueViolation(err)) {
        throw new ApiError(409, 'DUPLICATE_SLUG', 'News slug already exists');
      }
      throw err;
    }
  });
});

adminNewsRouter.delete('/:id', async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const [row] = await db.delete(news).where(eq(news.id, id)).returning();
    if (!row) {
      sendNotFound(res, 'News item');
      return;
    }
    res.json({ data: { id: row.id, deleted: true }, error: null });
  });
});
