import bcrypt from 'bcrypt';
import { eq } from 'drizzle-orm';
import { env } from '../config/env.js';
import { db } from './client.js';
import { admins } from './schema/admins.js';
import { districts } from './schema/districts.js';

const NEPAL_DISTRICTS = [
  { code: 'KTM', nameEn: 'Kathmandu', nameNe: 'काठमाडौं', provinceEn: 'Bagmati' },
  { code: 'LTP', nameEn: 'Lalitpur', nameNe: 'ललितपुर', provinceEn: 'Bagmati' },
  { code: 'BKT', nameEn: 'Bhaktapur', nameNe: 'भक्तपुर', provinceEn: 'Bagmati' },
  { code: 'PKR', nameEn: 'Pokhara', nameNe: 'पोखरा', provinceEn: 'Gandaki' },
  { code: 'BRT', nameEn: 'Biratnagar', nameNe: 'विराटनगर', provinceEn: 'Koshi' },
  { code: 'BRT2', nameEn: 'Birgunj', nameNe: 'वीरगञ्ज', provinceEn: 'Madhesh' },
  { code: 'DHG', nameEn: 'Dhangadhi', nameNe: 'धनगढी', provinceEn: 'Sudurpashchim' },
] as const;

async function seed() {
  const [existingAdmin] = await db.select().from(admins).limit(1);
  if (!existingAdmin) {
    const passwordHash = await bcrypt.hash(env.ADMIN_PASSWORD, 12);
    await db.insert(admins).values({
      username: env.ADMIN_USERNAME,
      passwordHash,
    });
    console.log(`Seeded admin user: ${env.ADMIN_USERNAME}`);
  }

  for (const d of NEPAL_DISTRICTS) {
    const [existing] = await db
      .select()
      .from(districts)
      .where(eq(districts.code, d.code))
      .limit(1);
    if (!existing) {
      await db.insert(districts).values({
        code: d.code,
        nameEn: d.nameEn,
        nameNe: d.nameNe,
        provinceEn: d.provinceEn,
      });
    }
  }

  console.log('Seed complete');
}

seed().catch((err) => {
  console.error('Seed failed:', err);
  process.exit(1);
});
