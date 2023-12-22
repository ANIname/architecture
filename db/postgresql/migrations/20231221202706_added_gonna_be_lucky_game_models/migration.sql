-- CreateEnum
CREATE TYPE "GameName" AS ENUM ('gonnaBeLucky');

-- CreateTable
CREATE TABLE "Game" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "title" "GameName" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Game_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameGonnaBeLucky" (
    "id" TEXT NOT NULL,
    "gameId" TEXT NOT NULL,
    "points" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "GameGonnaBeLucky_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameGonnaBeLuckyEvent" (
    "id" TEXT NOT NULL,
    "gameGonnaBeLuckyId" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "declination" TEXT NOT NULL,
    "points" INTEGER NOT NULL,
    "increase" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "GameGonnaBeLuckyEvent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Game_userId_title_key" ON "Game"("userId", "title");

-- CreateIndex
CREATE UNIQUE INDEX "GameGonnaBeLucky_gameId_key" ON "GameGonnaBeLucky"("gameId");

-- AddForeignKey
ALTER TABLE "Game" ADD CONSTRAINT "Game_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameGonnaBeLucky" ADD CONSTRAINT "GameGonnaBeLucky_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameGonnaBeLuckyEvent" ADD CONSTRAINT "GameGonnaBeLuckyEvent_gameGonnaBeLuckyId_fkey" FOREIGN KEY ("gameGonnaBeLuckyId") REFERENCES "GameGonnaBeLucky"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
