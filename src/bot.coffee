fs = require "fs"
user = require "./functions/user"

module.exports = (bot) ->
  # Начало с этого начинается работа бота
  bot.onText /\/start/, (msg) ->
    chatId = msg.chat.id
    author = msg.from
    message = """
    Привет, я виртуальный помощник, я могу помочь тебе с ..  
    А ещё я дарю подарки
    """
    await bot.sendMessage chatId, message

    message =
      "Чтобы предложить для тебя \
    полезную информацию, давай познакомимся поближе - ответь, \
    на сколько близко ты знаком с нами?"
    settings =
      inline_keyboard: [
        [
          text: "Моё первое знакомство"
          callback_data: "/greeting_command1"
        ,
          text: "Знаю, но никогда не покупала"
          callback_data: "/greeting_command2"
        ,
          text: "Являюсь клиентом кампании"
          callback_data: "/greeting_command3"
        ,
          text: "Являюсь партнёром кампании"
          callback_data: "/greeting_command4"
        ]
      ]
    await bot.sendMessage chatId, message, settings
    return

  # bot.onText /\/hello/, (msg) ->
  #   chatId = msg.chat.id
  #   bot.sendMessage chatId, "Здравствуйте #{ author.first_name }"

  # bot.on "message", (msg) ->
  #   chatId = msg.chat.id
  #   # Запускается в момент когда пользователь оставил контакт
  #   if msg.contact
  #     params = { reply_markup: { remove_keyboard: true } }
  #     User = await user.search(msg.contact.phone_number)
  #     if !User.isRegister()
  #       bot.sendMessage chatId, "Вы не зарегестрированы в системе!!!", params
  #     else if User.isNew()
  #       bot.sendMessage chatId, "Вы наш новичек!!!", params
  #     else
  #       bot.sendMessage chatId, "Вы наш старичек!!!", params
