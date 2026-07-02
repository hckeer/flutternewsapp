import type { NextFunction, Request, Response } from 'express';
import jwt from 'jsonwebtoken';
import { env } from '../config/env.js';
import { ApiError } from './errorHandler.js';

const ALLOWED_ALGORITHMS: jwt.Algorithm[] = ['HS256'];

export interface AuthPayload {
  sub: string;
  username: string;
}

declare global {
  namespace Express {
    interface Request {
      admin?: AuthPayload;
    }
  }
}

export function signToken(payload: AuthPayload): { token: string; expiresAt: string } {
  const token = jwt.sign(
    { username: payload.username },
    env.JWT_SECRET,
    {
      algorithm: 'HS256',
      expiresIn: env.JWT_EXPIRES_IN as jwt.SignOptions['expiresIn'],
      subject: payload.sub,
    },
  );

  const decoded = jwt.decode(token) as jwt.JwtPayload;
  const expiresAt = decoded.exp
    ? new Date(decoded.exp * 1000).toISOString()
    : new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString();

  return { token, expiresAt };
}

export function requireAuth(req: Request, _res: Response, next: NextFunction) {
  const header = req.headers.authorization;
  if (!header?.startsWith('Bearer ')) {
    next(new ApiError(401, 'UNAUTHORIZED', 'Missing or invalid authorization header'));
    return;
  }

  const token = header.slice(7);
  try {
    const decoded = jwt.verify(token, env.JWT_SECRET, {
      algorithms: ALLOWED_ALGORITHMS,
    }) as jwt.JwtPayload & AuthPayload;

    req.admin = {
      sub: decoded.sub ?? String(decoded.sub),
      username: decoded.username,
    };
    next();
  } catch {
    next(new ApiError(401, 'UNAUTHORIZED', 'Invalid or expired token'));
  }
}
