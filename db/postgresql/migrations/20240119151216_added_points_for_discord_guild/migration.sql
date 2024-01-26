-- CreateTable
CREATE TABLE "GameDiscordGuild" (
    "id" TEXT NOT NULL,
    "gameId" TEXT NOT NULL,
    "points" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "GameDiscordGuild_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameDiscordGuildEvent" (
    "id" TEXT NOT NULL,
    "gameDiscordGuildId" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "points" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "GameDiscordGuildEvent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "GameDiscordGuild_gameId_key" ON "GameDiscordGuild"("gameId");

-- AddForeignKey
ALTER TABLE "GameDiscordGuild" ADD CONSTRAINT "GameDiscordGuild_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameDiscordGuildEvent" ADD CONSTRAINT "GameDiscordGuildEvent_gameDiscordGuildId_fkey" FOREIGN KEY ("gameDiscordGuildId") REFERENCES "GameDiscordGuild"("id") ON DELETE CASCADE ON UPDATE CASCADE;
