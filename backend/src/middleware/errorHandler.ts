import type { NextFunction, Request, Response } from 'express';
import multer from 'multer';

export class ApiError extends Error {
  constructor(
    public statusCode: number,
    public code: string,
    message: string,
  ) {
    super(message);
    this.name = 'ApiError';
  }
}

export function errorHandler(
  err: unknown,
  _req: Request,
  res: Response,
  _next: NextFunction,
) {
  if (err instanceof ApiError) {
    res.status(err.statusCode).json({
      data: null,
      error: { code: err.code, message: err.message },
    });
    return;
  }

  if (err instanceof multer.MulterError) {
    res.status(400).json({
      data: null,
      error: { code: 'UPLOAD_ERROR', message: err.message },
    });
    return;
  }

  if (err instanceof Error && err.message.startsWith('Invalid file type')) {
    res.status(400).json({
      data: null,
      error: { code: 'INVALID_FILE_TYPE', message: err.message },
    });
    return;
  }

  console.error(err);
  res.status(500).json({
    data: null,
    error: { code: 'INTERNAL_ERROR', message: 'An unexpected error occurred' },
  });
}
