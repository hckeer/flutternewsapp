import { Router } from 'express';
import { requireAuth } from '../../middleware/auth.js';
import { adminArticlesRouter } from './articles.js';
import { adminContactsRouter } from './contacts.js';
import { adminDistrictsRouter } from './districts.js';
import { adminMediaRouter } from './media.js';
import { adminNewsRouter } from './news.js';
import { adminStatisticsRouter } from './statistics.js';

export const adminRouter = Router();

adminRouter.use(requireAuth);

adminRouter.use('/articles', adminArticlesRouter);
adminRouter.use('/news', adminNewsRouter);
adminRouter.use('/statistics', adminStatisticsRouter);
adminRouter.use('/districts', adminDistrictsRouter);
adminRouter.use('/contacts', adminContactsRouter);
adminRouter.use('/media', adminMediaRouter);
