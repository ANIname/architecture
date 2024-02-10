-- CreateTable
CREATE TABLE "DiscordBotContextMenuCommand" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "default_member_permissions" TEXT NOT NULL,
    "dm_permission" BOOLEAN NOT NULL DEFAULT false,
    "type" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "DiscordBotContextMenuCommand_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscordBotContextMenuCommandNameLocalization" (
    "id" TEXT NOT NULL,
    "commandId" TEXT NOT NULL,
    "uk" TEXT NOT NULL,
    "ru" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "DiscordBotContextMenuCommandNameLocalization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscordBotSlashCommand" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "default_member_permissions" TEXT NOT NULL,
    "dm_permission" BOOLEAN NOT NULL DEFAULT false,
    "nsfw" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "DiscordBotSlashCommand_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscordBotSlashCommandOption" (
    "id" TEXT NOT NULL,
    "commandId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "type" INTEGER NOT NULL,
    "required" BOOLEAN NOT NULL DEFAULT false,
    "autocomplete" BOOLEAN NOT NULL DEFAULT false,
    "max_value" INTEGER,
    "min_value" INTEGER,
    "max_length" INTEGER,
    "min_length" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "DiscordBotSlashCommandOption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscordBotSlashCommandOptionChoice" (
    "id" TEXT NOT NULL,
    "commandOptionId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "DiscordBotSlashCommandOptionChoice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscordBotSlashCommandOptionChoiceNameLocalization" (
    "id" TEXT NOT NULL,
    "commandOptionChoiceId" TEXT NOT NULL,
    "uk" TEXT NOT NULL,
    "ru" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "DiscordBotSlashCommandOptionChoiceNameLocalization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscordBotSlashCommandOptionNameLocalization" (
    "id" TEXT NOT NULL,
    "commandOptionId" TEXT NOT NULL,
    "uk" TEXT NOT NULL,
    "ru" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "DiscordBotSlashCommandOptionNameLocalization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscordBotSlashCommandOptionDescriptionLocalization" (
    "id" TEXT NOT NULL,
    "commandOptionId" TEXT NOT NULL,
    "uk" TEXT NOT NULL,
    "ru" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "DiscordBotSlashCommandOptionDescriptionLocalization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscordBotSlashCommandNameLocalization" (
    "id" TEXT NOT NULL,
    "commandId" TEXT NOT NULL,
    "uk" TEXT NOT NULL,
    "ru" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "DiscordBotSlashCommandNameLocalization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiscordBotSlashCommandDescriptionLocalization" (
    "id" TEXT NOT NULL,
    "commandId" TEXT NOT NULL,
    "uk" TEXT NOT NULL,
    "ru" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "DiscordBotSlashCommandDescriptionLocalization_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "DiscordBotContextMenuCommandNameLocalization_commandId_key" ON "DiscordBotContextMenuCommandNameLocalization"("commandId");

-- CreateIndex
CREATE UNIQUE INDEX "DiscordBotSlashCommandOptionChoiceNameLocalization_commandO_key" ON "DiscordBotSlashCommandOptionChoiceNameLocalization"("commandOptionChoiceId");

-- CreateIndex
CREATE UNIQUE INDEX "DiscordBotSlashCommandOptionNameLocalization_commandOptionI_key" ON "DiscordBotSlashCommandOptionNameLocalization"("commandOptionId");

-- CreateIndex
CREATE UNIQUE INDEX "DiscordBotSlashCommandOptionDescriptionLocalization_command_key" ON "DiscordBotSlashCommandOptionDescriptionLocalization"("commandOptionId");

-- CreateIndex
CREATE UNIQUE INDEX "DiscordBotSlashCommandNameLocalization_commandId_key" ON "DiscordBotSlashCommandNameLocalization"("commandId");

-- CreateIndex
CREATE UNIQUE INDEX "DiscordBotSlashCommandDescriptionLocalization_commandId_key" ON "DiscordBotSlashCommandDescriptionLocalization"("commandId");

-- AddForeignKey
ALTER TABLE "DiscordBotContextMenuCommandNameLocalization" ADD CONSTRAINT "DiscordBotContextMenuCommandNameLocalization_commandId_fkey" FOREIGN KEY ("commandId") REFERENCES "DiscordBotContextMenuCommand"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscordBotSlashCommandOption" ADD CONSTRAINT "DiscordBotSlashCommandOption_commandId_fkey" FOREIGN KEY ("commandId") REFERENCES "DiscordBotSlashCommand"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscordBotSlashCommandOptionChoice" ADD CONSTRAINT "DiscordBotSlashCommandOptionChoice_commandOptionId_fkey" FOREIGN KEY ("commandOptionId") REFERENCES "DiscordBotSlashCommandOption"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscordBotSlashCommandOptionChoiceNameLocalization" ADD CONSTRAINT "DiscordBotSlashCommandOptionChoiceNameLocalization_command_fkey" FOREIGN KEY ("commandOptionChoiceId") REFERENCES "DiscordBotSlashCommandOptionChoice"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscordBotSlashCommandOptionNameLocalization" ADD CONSTRAINT "DiscordBotSlashCommandOptionNameLocalization_commandOption_fkey" FOREIGN KEY ("commandOptionId") REFERENCES "DiscordBotSlashCommandOption"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscordBotSlashCommandOptionDescriptionLocalization" ADD CONSTRAINT "DiscordBotSlashCommandOptionDescriptionLocalization_comman_fkey" FOREIGN KEY ("commandOptionId") REFERENCES "DiscordBotSlashCommandOption"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscordBotSlashCommandNameLocalization" ADD CONSTRAINT "DiscordBotSlashCommandNameLocalization_commandId_fkey" FOREIGN KEY ("commandId") REFERENCES "DiscordBotSlashCommand"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiscordBotSlashCommandDescriptionLocalization" ADD CONSTRAINT "DiscordBotSlashCommandDescriptionLocalization_commandId_fkey" FOREIGN KEY ("commandId") REFERENCES "DiscordBotSlashCommand"("id") ON DELETE CASCADE ON UPDATE CASCADE;
