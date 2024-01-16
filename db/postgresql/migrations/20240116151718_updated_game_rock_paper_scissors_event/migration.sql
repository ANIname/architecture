/*
  Warnings:

  - You are about to drop the column `usersPlayedIds` on the `GameRockPaperScissorsEvent` table. All the data in the column will be lost.
  - Added the required column `points` to the `GameRockPaperScissorsEvent` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "GameRockPaperScissorsEvent" DROP COLUMN "usersPlayedIds",
ADD COLUMN     "losersIds" TEXT[],
ADD COLUMN     "points" INTEGER NOT NULL,
ADD COLUMN     "winnersIds" TEXT[];
