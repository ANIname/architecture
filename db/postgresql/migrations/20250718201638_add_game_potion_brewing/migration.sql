-- AlterEnum
ALTER TYPE "GameName" ADD VALUE 'potionBrewing';

-- CreateTable
CREATE TABLE "GamePotionBrewing" (
    "id" TEXT NOT NULL,
    "gameId" TEXT NOT NULL,
    "points" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "GamePotionBrewing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GamePotionBrewingEvent" (
    "id" TEXT NOT NULL,
    "gamePotionBrewingId" TEXT NOT NULL,
    "data" TEXT NOT NULL,
    "declination" TEXT NOT NULL,
    "points" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "GamePotionBrewingEvent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "GamePotionBrewing_gameId_key" ON "GamePotionBrewing"("gameId");

-- AddForeignKey
ALTER TABLE "GamePotionBrewing" ADD CONSTRAINT "GamePotionBrewing_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GamePotionBrewingEvent" ADD CONSTRAINT "GamePotionBrewingEvent_gamePotionBrewingId_fkey" FOREIGN KEY ("gamePotionBrewingId") REFERENCES "GamePotionBrewing"("id") ON DELETE CASCADE ON UPDATE CASCADE; 