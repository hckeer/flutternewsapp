import { eq } from 'drizzle-orm';
import { Router } from 'express';
import { db } from '../../db/client.js';
import { contacts } from '../../db/schema/contacts.js';
import { ApiError } from '../../middleware/errorHandler.js';
import { validateBody } from '../../middleware/validate.js';
import { assertDistrictExists, getById } from '../../services/refs.js';
import {
  createContactSchema,
  updateContactSchema,
  type CreateContactInput,
  type UpdateContactInput,
} from '../../validators/contacts.js';
import { handleRoute, parseIdParam, sendNotFound } from './helpers.js';

export const adminContactsRouter = Router();

adminContactsRouter.get('/', async (_req, res, next) => {
  await handleRoute(res, next, async () => {
    const rows = await db.select().from(contacts).orderBy(contacts.sortOrder);
    res.json({ data: rows, error: null });
  });
});

adminContactsRouter.get('/:id', async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const row = await getById(contacts, id);
    if (!row) {
      sendNotFound(res, 'Contact');
      return;
    }
    res.json({ data: row, error: null });
  });
});

adminContactsRouter.post('/', validateBody(createContactSchema), async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const body = req.body as CreateContactInput;
    if (body.districtId != null) await assertDistrictExists(body.districtId);

    const [row] = await db.insert(contacts).values(body).returning();
    res.status(201).json({ data: row, error: null });
  });
});

adminContactsRouter.put('/:id', validateBody(updateContactSchema), async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const existing = await getById(contacts, id);
    if (!existing) {
      sendNotFound(res, 'Contact');
      return;
    }

    const body = req.body as UpdateContactInput;
    if (body.districtId != null) await assertDistrictExists(body.districtId);

    const isActive = body.isActive ?? existing.isActive;
    if (isActive) {
      const result = updateContactSchema.safeParse({
        ...body,
        isActive,
        nameEn: body.nameEn !== undefined ? body.nameEn : existing.nameEn,
        nameNe: body.nameNe !== undefined ? body.nameNe : existing.nameNe,
      });
      if (!result.success) {
        throw new ApiError(
          400,
          'VALIDATION_ERROR',
          result.error.issues.map((i) => i.message).join('; '),
        );
      }
    }

    const [row] = await db
      .update(contacts)
      .set(body)
      .where(eq(contacts.id, id))
      .returning();
    res.json({ data: row, error: null });
  });
});

adminContactsRouter.delete('/:id', async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const [row] = await db.delete(contacts).where(eq(contacts.id, id)).returning();
    if (!row) {
      sendNotFound(res, 'Contact');
      return;
    }
    res.json({ data: { id: row.id, deleted: true }, error: null });
  });
});
