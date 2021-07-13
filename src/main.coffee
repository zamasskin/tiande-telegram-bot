settings = require "./settings"
TelegramBot = require "node-telegram-bot-api"
botInit = require "./bot"

bot = new TelegramBot settings.telegram_token, polling: true
botInit bot
