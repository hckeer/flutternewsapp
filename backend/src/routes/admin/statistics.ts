import { desc, eq } from 'drizzle-orm';
import { Router } from 'express';
import { db } from '../../db/client.js';
import { statistics } from '../../db/schema/statistics.js';
import { validateBody } from '../../middleware/validate.js';
import { assertDistrictExists, getById } from '../../services/refs.js';
import {
  createStatisticSchema,
  updateStatisticSchema,
  type CreateStatisticInput,
  type UpdateStatisticInput,
} from '../../validators/statistics.js';
import { handleRoute, parseIdParam, sendNotFound } from './helpers.js';

export const adminStatisticsRouter = Router();

adminStatisticsRouter.get('/', async (_req, res, next) => {
  await handleRoute(res, next, async () => {
    const rows = await db
      .select()
      .from(statistics)
      .orderBy(desc(statistics.reportedAt));
    res.json({ data: rows, error: null });
  });
});

adminStatisticsRouter.get('/:id', async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const row = await getById(statistics, id);
    if (!row) {
      sendNotFound(res, 'Statistic');
      return;
    }
    res.json({ data: row, error: null });
  });
});

adminStatisticsRouter.post('/', validateBody(createStatisticSchema), async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const body = req.body as CreateStatisticInput;
    await assertDistrictExists(body.districtId);

    const [row] = await db.insert(statistics).values(body).returning();
    res.status(201).json({ data: row, error: null });
  });
});

adminStatisticsRouter.put('/:id', validateBody(updateStatisticSchema), async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const existing = await getById(statistics, id);
    if (!existing) {
      sendNotFound(res, 'Statistic');
      return;
    }

    const body = req.body as UpdateStatisticInput;
    if (body.districtId != null) await assertDistrictExists(body.districtId);

    const [row] = await db
      .update(statistics)
      .set(body)
      .where(eq(statistics.id, id))
      .returning();
    res.json({ data: row, error: null });
  });
});

adminStatisticsRouter.delete('/:id', async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const [row] = await db.delete(statistics).where(eq(statistics.id, id)).returning();
    if (!row) {
      sendNotFound(res, 'Statistic');
      return;
    }
    res.json({ data: { id: row.id, deleted: true }, error: null });
  });
});
