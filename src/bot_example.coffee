fs = require "fs"

module.exports = (bot) ->
  # Пример отправвки простого сообщения
  bot.onText /^\/command1$/, (msg) ->
    chatId = msg.chat.id
    bot.sendMessage chatId, "Тестовое сообщение"

  # Пример запроса контактов и метоположений кнопки на одной строке
  bot.onText /\/command2$/, (msg) ->
    chatId = msg.chat.id
    bot.sendMessage chatId, "Запрос контанкта или местоположения на одной строке",
      {
        reply_markup: {
          keyboard: [
            [
              {text: 'Оставить контакт', request_contact: true},
              {text: 'Оставить местоположение', request_location: true},
            ]
          ]
        }
      }

  # Пример запроса контактов и метоположений кнопки на разных строках
  bot.onText /^\/command3$/, (msg) ->
    chatId = msg.chat.id
    bot.sendMessage chatId, "Тестовое сообщение",
      {
        reply_markup: {
          keyboard: [
            [
              {text: 'Оставить контакт', request_contact: true}
            ],
            [
              {text: 'Оставить местоположение', request_location: true}
            ]
          ]
        }
      }

  # Доп настройки для кнопок
  bot.onText /^\/command4$/, (msg) ->
    chatId = msg.chat.id
    bot.sendMessage chatId, "Клавиатура с параметрами",
      {
        reply_markup: {
          resize_keyboard: true, # Изменнять размер клавиатуры -> true/false
          one_time_keyboard: true # Скрывает клавиатуру как только она была использована -> true/false
          selective: false # Используйте этот параметр, если вы хотите показать клавиатуру только определенным пользователям -> true/false
          keyboard: [
            [
              {text: 'Оставить контакт', request_contact: true}
            ],
          ]
        }
      }

  # Пример Инлайн клавиатуры
  bot.onText /^\/command5$/, (msg) ->
    chatId = msg.chat.id
    bot.sendMessage chatId, "Клавиатура с параметрами",
      {
        reply_markup: {
          inline_keyboard: [
            [
              {text: 'Кнопка 1', callback_data: '/button_command1'},
              {text: 'Кнопка 2', callback_data: '/button_command2'}
            ],
            [
              {text: 'Кнопка 3', callback_data: '/button_command3'}
            ]
          ]
        }
      }

  # Обработка инлайн клавиатуры
  bot.on "callback_query", (query) ->
    msg = query.message
    chatId = msg.chat.id
    if query.data == "/button_command1"
      bot.sendMessage chatId, "Вы нажали на кнопку 1"
    else if query.data == "/button_command2"
      bot.sendMessage chatId, "Вы нажали на кнопку 2"
    else if query.data == "/button_command3"
      bot.sendMessage chatId, "Вы нажали на кнопку 3"


  # Пример закрытия клавиатуры
  bot.onText /^\/command6$/, (msg) ->
    chatId = msg.chat.id
    bot.sendMessage chatId, "Клавиатура закрвта",
      {
        reply_markup: {
          remove_keyboard: true
        }
      }

  # Пример многострочного сообщения
  bot.onText /^\/command8$/, (msg) ->
    chatId = msg.chat.id
    message = """
    Строка 1

    Строка 2
    Строка 3
    """
    bot.sendMessage chatId, message

  # Пример отправки видео
  bot.onText /^\/command9$/, (msg) ->
    chatId = msg.chat.id
    await bot.sendVideo chatId, fs.readFileSync "./video/example.mp4"
    await bot.sendVideo chatId, "./video/example_rect.mp4"

  # Пример отправки изображения
  bot.onText /^\/command10$/, (msg) ->
    chatId = msg.chat.id
    bot.sendPhoto chatId, fs.readFileSync "./images/example.jpeg"
