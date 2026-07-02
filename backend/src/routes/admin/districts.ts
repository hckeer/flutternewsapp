import { eq } from 'drizzle-orm';
import { Router } from 'express';
import { db } from '../../db/client.js';
import { districts } from '../../db/schema/districts.js';
import { ApiError } from '../../middleware/errorHandler.js';
import { validateBody } from '../../middleware/validate.js';
import { getById, isUniqueViolation } from '../../services/refs.js';
import {
  createDistrictSchema,
  updateDistrictSchema,
  type CreateDistrictInput,
  type UpdateDistrictInput,
} from '../../validators/districts.js';
import { handleRoute, parseIdParam, sendNotFound } from './helpers.js';

export const adminDistrictsRouter = Router();

adminDistrictsRouter.get('/', async (_req, res, next) => {
  await handleRoute(res, next, async () => {
    const rows = await db.select().from(districts).orderBy(districts.code);
    res.json({ data: rows, error: null });
  });
});

adminDistrictsRouter.get('/:id', async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const row = await getById(districts, id);
    if (!row) {
      sendNotFound(res, 'District');
      return;
    }
    res.json({ data: row, error: null });
  });
});

adminDistrictsRouter.post('/', validateBody(createDistrictSchema), async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const body = req.body as CreateDistrictInput;
    try {
      const [row] = await db.insert(districts).values(body).returning();
      res.status(201).json({ data: row, error: null });
    } catch (err) {
      if (isUniqueViolation(err)) {
        throw new ApiError(409, 'DUPLICATE_CODE', 'District code already exists');
      }
      throw err;
    }
  });
});

adminDistrictsRouter.put('/:id', validateBody(updateDistrictSchema), async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const existing = await getById(districts, id);
    if (!existing) {
      sendNotFound(res, 'District');
      return;
    }

    const body = req.body as UpdateDistrictInput;
    try {
      const [row] = await db
        .update(districts)
        .set(body)
        .where(eq(districts.id, id))
        .returning();
      res.json({ data: row, error: null });
    } catch (err) {
      if (isUniqueViolation(err)) {
        throw new ApiError(409, 'DUPLICATE_CODE', 'District code already exists');
      }
      throw err;
    }
  });
});

adminDistrictsRouter.delete('/:id', async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const [row] = await db.delete(districts).where(eq(districts.id, id)).returning();
    if (!row) {
      sendNotFound(res, 'District');
      return;
    }
    res.json({ data: { id: row.id, deleted: true }, error: null });
  });
});
