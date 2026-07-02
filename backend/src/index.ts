import cors from 'cors';
import express from 'express';
import helmet from 'helmet';
import { env } from './config/env.js';
import './db/client.js';
import { errorHandler } from './middleware/errorHandler.js';
import { adminRouter } from './routes/admin/index.js';
import { authRouter } from './routes/auth.js';
import {
  publicArticlesRouter,
  publicContactsRouter,
  publicDistrictsRouter,
  publicNewsRouter,
  publicStatisticsRouter,
} from './routes/public/index.js';

const app = express();

app.use(helmet());
app.use(
  cors({
    origin: true,
    credentials: true,
  }),
);
app.use(express.json({ limit: '1mb' }));

app.get('/health', (_req, res) => {
  res.json({ data: { status: 'ok' }, error: null });
});

app.use('/api/auth', authRouter);
app.use('/api/public/articles', publicArticlesRouter);
app.use('/api/public/news', publicNewsRouter);
app.use('/api/public/statistics', publicStatisticsRouter);
app.use('/api/public/districts', publicDistrictsRouter);
app.use('/api/public/contacts', publicContactsRouter);
app.use('/api/admin', adminRouter);

app.use(errorHandler);

app.listen(env.PORT, () => {
  console.log(`API listening on http://localhost:${env.PORT}`);
});
