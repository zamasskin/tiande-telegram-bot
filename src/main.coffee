TelegramBot = require("node-telegram-bot-api")
settings = require "./settings"
botInit = require "./bot"
botExampleInit = require "./bot_example"

bot = new TelegramBot(settings.telegram_token, {  polling: true })
botInit(bot)
botExampleInit(bot)
