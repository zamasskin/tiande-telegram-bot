dotenv = require "dotenv"

dotenv.config()
settings =
  telegram_token: process.env.TELEGRAM_TOKEN
  db_host: process.env.DB_HOST
  db_port: process.env.DB_PORT
  db_user: process.env.DB_USER
  db_pass: process.env.DB_PASS
  database: process.env.DB_NAME
  ios_url:
    "https://apps.apple.com/ru/app/tiande-%D0%B8%D0%\
    BD%D1%82%D0%B5%D1%80%D0%BD%D0%B5%D1%82-%D0%BC%D0%\
    B0%D0%B3%D0%B0%D0%B7%D0%B8%D0%BD/id1248325926"
  android_url:
    "https://play.google.com/store/apps/details?id=com.tiandeapp&hl=ru"
module.exports = settings
