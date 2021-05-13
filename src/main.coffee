TelegramBot = require("node-telegram-bot-api")
settings = require "./settings"
botInit = require "./bot"

bot = new TelegramBot(settings.telegram_token, { polling: true })
botInit(bot)
