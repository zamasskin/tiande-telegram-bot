mysql2 = require "mysql2"
settings = require "../settings"


pool = mysql2.createPool {
  connectionLimit: 12,
  host: settings.db_host,
  port: settings.db_port,
  user: settings.db_user,
  password: settings.db_pass,
  database: settings.database,
  multipleStatements: true,
}

module.exports = {
  query: (sql, values) ->
    [rows] = await pool.promise().query(sql, values)
    rows
}
  