-- CreateEnum
CREATE TYPE "UserGender" AS ENUM ('male', 'female', 'other', 'preferNotToSay');

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "gender" "UserGender" NOT NULL DEFAULT 'preferNotToSay';
