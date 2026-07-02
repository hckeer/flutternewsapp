import type { NextFunction, Request, Response } from 'express';
import { z } from 'zod';
import { ApiError } from '../../middleware/errorHandler.js';

export function parseIdParam(req: Request): number {
  const result = z.coerce.number().int().positive().safeParse(req.params.id);
  if (!result.success) {
    throw new ApiError(400, 'INVALID_ID', 'Invalid resource id');
  }
  return result.data;
}

export async function handleRoute(
  res: Response,
  next: NextFunction,
  handler: () => Promise<void>,
) {
  try {
    await handler();
  } catch (err) {
    next(err);
  }
}

export function sendNotFound(res: Response, resource: string) {
  res.status(404).json({
    data: null,
    error: { code: 'NOT_FOUND', message: `${resource} not found` },
  });
}
