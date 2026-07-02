import { eq } from 'drizzle-orm';
import { Router } from 'express';
import bcrypt from 'bcrypt';
import rateLimit from 'express-rate-limit';
import { z } from 'zod';
import { db } from '../db/client.js';
import { admins } from '../db/schema/admins.js';
import { signToken } from '../middleware/auth.js';
import { ApiError } from '../middleware/errorHandler.js';
import { validateBody } from '../middleware/validate.js';

const loginSchema = z.object({
  username: z.string().min(1),
  password: z.string().min(1),
});

export const authRouter = Router();

authRouter.post(
  '/login',
  rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 10,
    standardHeaders: true,
    legacyHeaders: false,
    message: {
      data: null,
      error: { code: 'RATE_LIMITED', message: 'Too many login attempts' },
    },
  }),
  validateBody(loginSchema),
  async (req, res, next) => {
    try {
      const { username, password } = req.body as z.infer<typeof loginSchema>;
      const [admin] = await db
        .select()
        .from(admins)
        .where(eq(admins.username, username))
        .limit(1);

      if (!admin || !(await bcrypt.compare(password, admin.passwordHash))) {
        throw new ApiError(401, 'INVALID_CREDENTIALS', 'Invalid username or password');
      }

      const { token, expiresAt } = signToken({
        sub: String(admin.id),
        username: admin.username,
      });

      res.json({ data: { token, expiresAt }, error: null });
    } catch (err) {
      next(err);
    }
  },
);
