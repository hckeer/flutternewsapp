import { desc, eq } from 'drizzle-orm';
import { Router } from 'express';
import { upload } from '../../config/upload.js';
import { db } from '../../db/client.js';
import { media } from '../../db/schema/media.js';
import { ApiError } from '../../middleware/errorHandler.js';
import { getById } from '../../services/refs.js';
import {
  createStorageObjectPath,
  deleteMediaObject,
  uploadMediaObject,
} from '../../services/storage.js';
import { handleRoute, parseIdParam, sendNotFound } from './helpers.js';

export const adminMediaRouter = Router();

adminMediaRouter.get('/', async (_req, res, next) => {
  await handleRoute(res, next, async () => {
    const rows = await db.select().from(media).orderBy(desc(media.createdAt));
    res.json({ data: rows, error: null });
  });
});

adminMediaRouter.get('/:id', async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const row = await getById(media, id);
    if (!row) {
      sendNotFound(res, 'Media');
      return;
    }
    res.json({ data: row, error: null });
  });
});

adminMediaRouter.post('/upload', upload.single('file'), async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const file = req.file;
    if (!file) {
      throw new ApiError(400, 'NO_FILE', 'No file uploaded. Use field name "file".');
    }

    const objectPath = createStorageObjectPath(file.originalname);
    const urlPath = await uploadMediaObject({
      objectPath,
      content: file.buffer,
      contentType: file.mimetype,
    });

    const [row] = await db
      .insert(media)
      .values({
        filename: objectPath,
        originalName: file.originalname,
        mimeType: file.mimetype,
        sizeBytes: file.size,
        urlPath,
      })
      .returning();

    res.status(201).json({ data: row, error: null });
  });
});

adminMediaRouter.delete('/:id', async (req, res, next) => {
  await handleRoute(res, next, async () => {
    const id = parseIdParam(req);
    const [row] = await db.delete(media).where(eq(media.id, id)).returning();
    if (!row) {
      sendNotFound(res, 'Media');
      return;
    }

    await deleteMediaObject(row.filename);

    res.json({ data: { id: row.id, deleted: true }, error: null });
  });
});
