db = require("./db")
moment = require("moment")


module.exports = {
  search: (phone) ->
    search = [phone, "+" + phone]
    rows = await Promise.all([
      db.query "SELECT ID id FROM b_user WHERE PERSONAL_MOBILE IN (?)", [search]
      db.query "SELECT ID id FROM b_user WHERE PERSONAL_PHONE IN (?)", [search]
      db.query "SELECT VALUE_ID id FROM b_uts_user WHERE UF_MOBILE_PHONE_INT IN (?)", [search]
      db.query "SELECT VALUE_ID id FROM b_uts_user WHERE UF_MOB_PHONE_FORMAT IN (?)", [search]
    ])

    id = []
    rows.forEach (subRow) ->
      subRow.forEach (data) ->
        id.push(data.id)
    user = false
    if id.length > 0
      sql = """
      SELECT * FROM b_user WHERE DATE_REGISTER >= DATE_FORMAT(now(), "%Y-%m-01") AND ID IN (?)
      """
      rows = await db.query sql, [id]
      if rows.length > 0
        user = rows[0]
        
    {
      isRegister: () ->
        return id.length > 0
      isNew: () ->
        return user != false
      setTelegramId: (telegramId) ->
        if user != false
          await db.query "UPDATE b_user SET ? WHERE ID = ?", [
            { UF_TELEGRAM_ID: telegramId },
            user.ID
          ]
    }
}
  