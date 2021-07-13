fs = require "fs"
user = require "./functions/user"
settings = require "./settings"

module.exports = (bot) ->
  get_contact_settings = (mess) ->
    return
      reply_markup:
        keyboard: [[text: mess, request_contact: true]]

  # Привествие
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
      reply_markup:
        inline_keyboard: [
          [
            text: "Моё первое знакомство"
            callback_data: "/my_first_acquaintance"
          ]
          [
            text: "Знаю, но никогда не покупала"
            callback_data: "/i_know_but_never_bought"
          ]
          [
            text: "Являюсь клиентом кампании"
            callback_data: "/i_am_a_client_campaigns"
          ]
          [
            text: "Являюсь партнёром кампании"
            callback_data: "/i_am_a_partner_in_the_campaign"
          ]
        ]
    await bot.sendMessage chatId, message, settings
    return

  bot.onText /\/main_menu/, (msg) -> main msg

  my_first_acquaintance = (msg) ->
    chatId = msg.chat.id
    message =
      "Здорово, рады знакомству! \
      Давай, сначала я расскажу тебе о \
      нашей компании, а конце тебя будет \
      ждать приятный сюрприз"
    settings =
      reply_markup:
        inline_keyboard: [
          [
            text: "Поехали!"
            callback_data: "/main_menu"
          ]
        ]
    await bot.sendMessage chatId, message, settings

  i_know_but_never_bought = (msg) ->
    chatId = msg.chat.id
    message = """
    Супер, это очень здорово и приятно, что люди знакомы с нашей продукцией!
    Тогда предлагаем познакомиться по ближе, \
    а где-то освежить в памяти забытое. И да, \
    в конце тебя будет ждать приятный сюрприз
    """
    settings =
      reply_markup:
        inline_keyboard: [
          [
            text: "Поехали!"
            callback_data: "/main_menu"
          ]
        ]
    await bot.sendMessage chatId, message, settings

  i_am_a_client_campaigns = (msg) ->
    chatId = msg.chat.id
    message = """
    Клас! Спасибо за то, что уже с нами!

    Далее тебя ожидает множество полезной информации, \
    а так же ты узнаешь о том как получить подарок от меня!
    """
    settings =
      reply_markup:
        inline_keyboard: [
          [
            text: "Поехали!"
            callback_data: "/main_menu"
          ]
        ]
    await bot.sendMessage chatId, message, settings

  i_am_a_partner_in_the_campaign = (msg) ->
    chatId = msg.chat.id
    message = """
    Выражаем глубочайшее почтение, за то что строите бизнес вместе с нами!

    Далее Вас ожидает библиотека самой актуальной и полезной \
    информации, сделанной специально для наших партнёров

    А так же Вы узнаете, как получить от меня подарок.
    """
    settings =
      reply_markup:
        inline_keyboard: [
          [
            text: "Поехали!"
            callback_data: "/main_menu"
          ]
        ]
    await bot.sendMessage chatId, message, settings

  bot.on "callback_query", (query) ->
    msg = query.message
    chatId = msg.chat.id
    if query.data == "/my_first_acquaintance"
      my_first_acquaintance msg
    else if query.data == "/i_know_but_never_bought"
      i_know_but_never_bought msg
    else if query.data == "/i_am_a_client_campaigns"
      i_am_a_client_campaigns msg
    else if query.data == "/i_am_a_partner_in_the_campaign"
      i_am_a_partner_in_the_campaign msg
    else if query.data == "/main_menu"
      console.log "main"
      main msg

  main = (msg) ->
    chatId = msg.chat.id
    message = """
    Наша компания, философия, производство, продукция, бизнес коротко и тезисно.
    "О чём бы Вы хотели узнать подробнее?"
    """
    settings =
      reply_markup:
        inline_keyboard: [
          [
            text: "В чём Ваша продукция особенная?"
            callback_data: "/m_feature"
          ]
          [
            text: "Направления продукции"
            callback_data: "/m_directions"
          ]
          [
            text: "Что говорят о Вашей продукции клиенты?"
            callback_data: "/m_what_people_are_saying"
          ]
          [
            text: "Где посмотреть продукцию и как сделать заказ?"
            callback_data: "/m_where_to_look"
          ]
          [
            text: "Как получить заказ?"
            callback_data: "/m_how_to_get"
          ]
          [
            text:
              "Хотите больше? Получайте привелегии \
              став консультантом и бизнес-партнёром"
            callback_data: "/m_want_more"
          ]
          [
            text: "Получить подарок"
            callback_data: "/m_get_gift"
          ]
        ]
    await bot.sendMessage chatId, message, settings

  bot.onText /\/m_feature/, (msg) -> m_feature msg
  bot.onText /\/m_directions/, (msg) -> m_directions msg
  bot.onText /\/m_what_people_are_saying/, (msg) -> m_what_people_are_saying msg
  bot.onText /\/m_where_to_look/, (msg) -> m_where_to_look msg
  bot.onText /\/m_how_to_get/, (msg) -> m_how_to_get msg
  bot.onText /\/m_want_more/, (msg) -> m_want_more msg
  bot.onText /\/what_is_business_with_tian_de/, (msg) ->
    what_is_business_with_tian_de msg
  bot.onText /\/m_get_gift/, (msg) -> m_get_gift msg

  bot.on "callback_query", (query) ->
    msg = query.message
    switch query.data
      when "/m_feature" then m_feature msg
      when "/m_directions" then m_directions msg
      when "/m_what_people_are_saying" then m_what_people_are_saying msg
      when "/m_where_to_look" then m_where_to_look msg
      when "/m_how_to_get" then m_how_to_get msg
      when "/m_want_more" then m_want_more msg
      when "/what_is_business_with_tian_de"
        what_is_business_with_tian_de msg
      when "/m_get_gift" then m_get_gift msg

  m_feature = (msg) ->
    chatId = msg.chat.id
    message = "Интересный, цепляющий текст"
    await bot.sendMessage chatId, message

  m_directions = (msg) ->
    chatId = msg.chat.id
    message =
      "Все разделы: Фото - описание - \
      ссылка на сайте с диплинком, чтобы из инсты не выходить."
    await bot.sendMessage chatId, message

  m_what_people_are_saying = (msg) ->
    chatId = msg.chat.id
    message = "Интересный, цепляющий текст"
    await bot.sendMessage chatId, message

  m_where_to_look = (msg) ->
    chatId = msg.chat.id
    message = "Для заказа воспользуйтесь любым методом на выбор"
    await bot.sendMessage chatId, message
    message = "Скачать приложение и зарегистрироваться"
    setting =
      reply_markup:
        inline_keyboard: [
          [
            text: "IOS"
            url: settings.ios_url
          ,
            text: "ANDROID"
            url: settings.android_url
          ]
        ]
    await bot.sendMessage chatId, message, setting
    message = "Просто написать нам сюда:"
    await bot.sendMessage chatId, message
    message = "Позвонить по телефону 8-800-700-70-95"
    settings =
      reply_markup:
        inline_keyboard: [
          [
            text: "назад"
            callback_data: "/main_menu"
          ]
        ]
    await bot.sendMessage chatId, message, settings

  m_how_to_get = (msg) ->
    chatId = msg.chat.id
    message = """Заказ можно получить несколькими способами: \
      Самовывоз из бутиков TianDe, Самовывоз из пунктов выдачи, \
      Адресная доставка, Наложенным платежом.
      Адреса бутиков Вы сможете узнать в \
      приложении после регистрации, либо запросить у менеджеров @xxx
      """
    settings =
      reply_markup:
        inline_keyboard: [
          [
            text: "назад"
            callback_data: "/main_menu"
          ]
        ]
    await bot.sendMessage chatId, message, settings

  m_want_more = (msg) ->
    chatId = msg.chat.id
    message = """
    Вы можете получать дополнительный доход, \
    получать скидки и привилегии или же построить полноценный бизнес с Tiande
    """
    settings =
      reply_markup:
        inline_keyboard: [
          [
            text: "Что такое Бизнес с TianDe?"
            callback_data: "/what_is_business_with_tian_de"
          ]
        ]
    await bot.sendMessage chatId, message, settings

  what_is_business_with_tian_de = (msg) ->
    chatId = msg.chat.id
    message = "Бизнес с TianDe - это..."
    await bot.sendMessage chatId, message

  m_get_gift = (msg) ->
    chatId = msg.chat.id
    message = "Получение подарка инфо"
    await bot.sendMessage chatId, message
