/*
  Warnings:

  - You are about to drop the column `increase` on the `GameGonnaBeLuckyEvent` table. All the data in the column will be lost.
  - You are about to drop the column `message` on the `GameGonnaBeLuckyEvent` table. All the data in the column will be lost.
  - Added the required column `data` to the `GameGonnaBeLuckyEvent` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "GameGonnaBeLuckyEvent" DROP COLUMN "increase",
DROP COLUMN "message",
ADD COLUMN     "data" TEXT NOT NULL;
