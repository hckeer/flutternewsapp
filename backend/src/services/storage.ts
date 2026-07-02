import crypto from 'node:crypto';
import path from 'node:path';
import { createClient } from '@supabase/supabase-js';
import { env } from '../config/env.js';

const supabase = createClient(env.SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY, {
  auth: { persistSession: false },
});

export function createStorageObjectPath(originalName: string) {
  const ext = path.extname(originalName).toLowerCase();
  const hash = crypto.randomBytes(16).toString('hex');
  return `media/${hash}${ext}`;
}

export async function uploadMediaObject(params: {
  objectPath: string;
  content: Buffer;
  contentType: string;
}) {
  const { error } = await supabase.storage
    .from(env.SUPABASE_STORAGE_BUCKET)
    .upload(params.objectPath, params.content, {
      contentType: params.contentType,
      upsert: false,
    });

  if (error) {
    throw new Error(`Failed to upload media to Supabase Storage: ${error.message}`);
  }

  const { data } = supabase.storage
    .from(env.SUPABASE_STORAGE_BUCKET)
    .getPublicUrl(params.objectPath);

  return data.publicUrl;
}

export async function deleteMediaObject(objectPath: string) {
  const { error } = await supabase.storage
    .from(env.SUPABASE_STORAGE_BUCKET)
    .remove([objectPath]);

  if (error) {
    throw new Error(`Failed to delete media from Supabase Storage: ${error.message}`);
  }
}
