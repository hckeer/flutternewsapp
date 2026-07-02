import { desc, eq } from 'drizzle-orm';
import { Router } from 'express';
import { db } from '../../db/client.js';
import { articles } from '../../db/schema/articles.js';
import { validateBody } from '../../middleware/validate.js';
import {
  assertMediaExists,
  getById,
  isUniqueViolation,
  normalizePublishedAt,
} from '../../services/refs.js';
import {
  createArticleSchema,
  updateArticleSchema,
  type CreateArticleInput,
  type UpdateArticleInput,
} from '../../validators/articles.js';
import { ApiError } from '../../middleware/errorHandler.js';
import { handleRoute, parseIdParam, sendNotFound } from './helpers.js';

export const adminArticlesRouter = Router();

adminArticlesRouter.get('/', async (_req, res, next) => {
  await handleRoute(res, next, async () => {
    const rows = await db.select().from(articles).orderBy(desc(articles.updatedAt));
    res.json({ data: rows, error: null });
  });
});

adminArticlesRouter.get('/:id', async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const row = await getById(articles, id);
    if (!row) {
      sendNotFound(res, 'Article');
      return;
    }
    res.json({ data: row, error: null });
  });
});

adminArticlesRouter.post(
  '/',
  validateBody(createArticleSchema),
  async (req, res, next) => {
    await handleRoute(res, next, async () => {
      const body = req.body as CreateArticleInput;
      await assertMediaExists(body.coverMediaId);
      const publishedAt = normalizePublishedAt(body.status, body.publishedAt);

      try {
        const [row] = await db
          .insert(articles)
          .values({ ...body, publishedAt })
          .returning();
        res.status(201).json({ data: row, error: null });
      } catch (err) {
        if (isUniqueViolation(err)) {
          throw new ApiError(409, 'DUPLICATE_SLUG', 'Article slug already exists');
        }
        throw err;
      }
    });
  },
);

adminArticlesRouter.put(
  '/:id',
  validateBody(updateArticleSchema),
  async (req, res, next) => {
    await handleRoute(res, next, async () => {
      const id = parseIdParam(req);
      const existing = await getById(articles, id);
      if (!existing) {
        sendNotFound(res, 'Article');
        return;
      }

      const body = req.body as UpdateArticleInput;
      await assertMediaExists(body.coverMediaId);

      const status = body.status ?? existing.status;
      const publishedAt = normalizePublishedAt(
        status,
        body.publishedAt !== undefined ? body.publishedAt : existing.publishedAt,
      );

      if (status === 'published') {
        const merged = {
          titleEn: body.titleEn !== undefined ? body.titleEn : existing.titleEn,
          titleNe: body.titleNe !== undefined ? body.titleNe : existing.titleNe,
          bodyEn: body.bodyEn !== undefined ? body.bodyEn : existing.bodyEn,
          bodyNe: body.bodyNe !== undefined ? body.bodyNe : existing.bodyNe,
        };
        const result = updateArticleSchema.safeParse({
          ...body,
          status,
          publishedAt,
          ...merged,
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
          .update(articles)
          .set({ ...body, status, publishedAt })
          .where(eq(articles.id, id))
          .returning();
        res.json({ data: row, error: null });
      } catch (err) {
        if (isUniqueViolation(err)) {
          throw new ApiError(409, 'DUPLICATE_SLUG', 'Article slug already exists');
        }
        throw err;
      }
    });
  },
);

adminArticlesRouter.delete('/:id', async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const [row] = await db.delete(articles).where(eq(articles.id, id)).returning();
    if (!row) {
      sendNotFound(res, 'Article');
      return;
    }
    res.json({ data: { id: row.id, deleted: true }, error: null });
  });
});
