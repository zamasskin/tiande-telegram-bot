dotenv = require "dotenv"

dotenv.config()
settings = {
  telegram_token: process.env.TELEGRAM_TOKEN
  db_host: process.env.DB_HOST
  db_port: process.env.DB_PORT
  db_user: process.env.DB_USER
  db_pass: process.env.DB_PASS
  database: process.env.DB_NAME
}
module.exports = settings