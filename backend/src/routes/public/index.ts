import { desc, eq } from 'drizzle-orm';
import { Router } from 'express';
import { db } from '../../db/client.js';
import { articles } from '../../db/schema/articles.js';
import { contacts } from '../../db/schema/contacts.js';
import { districts } from '../../db/schema/districts.js';
import { media } from '../../db/schema/media.js';
import { news } from '../../db/schema/news.js';
import { statistics } from '../../db/schema/statistics.js';

function withCoverMediaUrl<T extends { coverMediaId: number | null }>(
  row: T,
  cover: { urlPath: string } | null,
) {
  return {
    ...row,
    coverMediaUrl: cover?.urlPath ?? null,
  };
}

export const publicArticlesRouter = Router();

publicArticlesRouter.get('/', async (_req, res, next) => {
  try {
    const rows = await db
      .select()
      .from(articles)
      .leftJoin(media, eq(articles.coverMediaId, media.id))
      .where(eq(articles.status, 'published'))
      .orderBy(desc(articles.publishedAt));
    res.json({
      data: rows.map(({ articles, media }) => withCoverMediaUrl(articles, media)),
      error: null,
    });
  } catch (err) {
    next(err);
  }
});

publicArticlesRouter.get('/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    const [row] = await db
      .select()
      .from(articles)
      .leftJoin(media, eq(articles.coverMediaId, media.id))
      .where(eq(articles.id, id))
      .limit(1);

    if (!row || row.articles.status !== 'published') {
      res.status(404).json({
        data: null,
        error: { code: 'NOT_FOUND', message: 'Article not found' },
      });
      return;
    }

    res.json({ data: withCoverMediaUrl(row.articles, row.media), error: null });
  } catch (err) {
    next(err);
  }
});

export const publicNewsRouter = Router();

publicNewsRouter.get('/', async (_req, res, next) => {
  try {
    const rows = await db
      .select()
      .from(news)
      .leftJoin(media, eq(news.coverMediaId, media.id))
      .where(eq(news.status, 'published'))
      .orderBy(desc(news.publishedAt));
    res.json({
      data: rows.map(({ news, media }) => withCoverMediaUrl(news, media)),
      error: null,
    });
  } catch (err) {
    next(err);
  }
});

export const publicStatisticsRouter = Router();

publicStatisticsRouter.get('/', async (req, res, next) => {
  try {
    const districtId = req.query.district_id
      ? Number(req.query.district_id)
      : undefined;

    const rows = districtId
      ? await db
          .select()
          .from(statistics)
          .where(eq(statistics.districtId, districtId))
      : await db.select().from(statistics);

    res.json({ data: rows, error: null });
  } catch (err) {
    next(err);
  }
});

export const publicDistrictsRouter = Router();

publicDistrictsRouter.get('/', async (_req, res, next) => {
  try {
    const rows = await db.select().from(districts);
    res.json({ data: rows, error: null });
  } catch (err) {
    next(err);
  }
});

export const publicContactsRouter = Router();

publicContactsRouter.get('/', async (_req, res, next) => {
  try {
    const rows = await db
      .select()
      .from(contacts)
      .where(eq(contacts.isActive, true))
      .orderBy(contacts.sortOrder);
    res.json({ data: rows, error: null });
  } catch (err) {
    next(err);
  }
});
