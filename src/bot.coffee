fs = require "fs"
user = require "./functions/user"

module.exports = (bot) ->
  # Начало с этого начинается работа бота
  bot.onText /\/start/, (msg) ->
  
    chatId = msg.chat.id
    author = msg.from
    bot.sendMessage chatId, "Здравствуйте #{ author.first_name }"
    # bot.sendVideo chatId, fs.readFileSync "./video/create_bot.mp4"
    bot.sendMessage chatId, "Для участия поделиитесь вашим контактом",
      {
        reply_markup: {
          keyboard: [
            [
              { text: 'Оставить контакт', request_contact: true },
              { text: 'Оставить контакт', request_contact: true },
            ], [
              { text: 'Оставить контакт', request_contact: true },
            ]
          ],
        },
      }
      
    return

  bot.onText /\/hello/, (msg) ->
    chatId = msg.chat.id
    bot.sendMessage chatId, "Здравствуйте #{ author.first_name }"

  bot.on "message", (msg) ->
    chatId = msg.chat.id
    # Запускается в момент когда пользователь оставил контакт
    if msg.contact
      params = { reply_markup: { remove_keyboard: true } }
      User = await user.search(msg.contact.phone_number)
      if !User.isRegister()
        bot.sendMessage chatId, "Вы не зарегестрированы в системе!!!", params
      else if User.isNew()
        bot.sendMessage chatId, "Вы наш новичек!!!", params
      else
        bot.sendMessage chatId, "Вы наш старичек!!!", params
