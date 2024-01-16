-- CreateEnum
CREATE TYPE "GameRockPaperScissorsChoice" AS ENUM ('rock', 'paper', 'scissors');

-- CreateEnum
CREATE TYPE "GameRockPaperScissorsEventStatus" AS ENUM ('win', 'lose', 'draw');

-- AlterEnum
ALTER TYPE "GameName" ADD VALUE 'rockPaperScissors';

-- CreateTable
CREATE TABLE "GameRockPaperScissors" (
    "id" TEXT NOT NULL,
    "gameId" TEXT NOT NULL,
    "points" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "GameRockPaperScissors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameRockPaperScissorsEvent" (
    "id" TEXT NOT NULL,
    "gameRockPaperScissorsId" TEXT NOT NULL,
    "usersPlayedIds" TEXT[],
    "choice" "GameRockPaperScissorsChoice" NOT NULL,
    "status" "GameRockPaperScissorsEventStatus" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "GameRockPaperScissorsEvent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "GameRockPaperScissors_gameId_key" ON "GameRockPaperScissors"("gameId");

-- AddForeignKey
ALTER TABLE "GameRockPaperScissors" ADD CONSTRAINT "GameRockPaperScissors_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameRockPaperScissorsEvent" ADD CONSTRAINT "GameRockPaperScissorsEvent_gameRockPaperScissorsId_fkey" FOREIGN KEY ("gameRockPaperScissorsId") REFERENCES "GameRockPaperScissors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
