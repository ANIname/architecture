-- DropForeignKey
ALTER TABLE "GameGonnaBeLucky" DROP CONSTRAINT "GameGonnaBeLucky_gameId_fkey";

-- DropForeignKey
ALTER TABLE "GameGonnaBeLuckyEvent" DROP CONSTRAINT "GameGonnaBeLuckyEvent_gameGonnaBeLuckyId_fkey";

-- DropForeignKey
ALTER TABLE "GameRockPaperScissors" DROP CONSTRAINT "GameRockPaperScissors_gameId_fkey";

-- DropForeignKey
ALTER TABLE "GameRockPaperScissorsEvent" DROP CONSTRAINT "GameRockPaperScissorsEvent_gameRockPaperScissorsId_fkey";

-- AddForeignKey
ALTER TABLE "GameGonnaBeLucky" ADD CONSTRAINT "GameGonnaBeLucky_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameGonnaBeLuckyEvent" ADD CONSTRAINT "GameGonnaBeLuckyEvent_gameGonnaBeLuckyId_fkey" FOREIGN KEY ("gameGonnaBeLuckyId") REFERENCES "GameGonnaBeLucky"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameRockPaperScissors" ADD CONSTRAINT "GameRockPaperScissors_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameRockPaperScissorsEvent" ADD CONSTRAINT "GameRockPaperScissorsEvent_gameRockPaperScissorsId_fkey" FOREIGN KEY ("gameRockPaperScissorsId") REFERENCES "GameRockPaperScissors"("id") ON DELETE CASCADE ON UPDATE CASCADE;
