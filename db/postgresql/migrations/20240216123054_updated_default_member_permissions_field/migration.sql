-- AlterTable
ALTER TABLE "DiscordBotContextMenuCommand" ALTER COLUMN "default_member_permissions" DROP NOT NULL;

-- AlterTable
ALTER TABLE "DiscordBotSlashCommand" ALTER COLUMN "default_member_permissions" DROP NOT NULL;
