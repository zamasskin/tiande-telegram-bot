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

  bot.onText /\/main_menu/, main

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
    await bot.sendMessage chatId, message

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
    else if query.data == "main_menu"
      main msg

  main = (msg) ->
    chatId = msg.chat.id
    message = """
    Наша компания, философия, производство, продукция, бизнес коротко и тезисно.
    "О чём бы Вы хотели узнать подробнее?"

    /m_feature - В чём Ваша продукция особенная?
    /m_directions - Направления продукции
    /m_what_people_are_saying - Что говорят о Вашей продукции клиенты?
    /m_where_to_look - Где посмотреть продукцию и как сделать заказ?
    /m_how_to_get - Как получить заказ?
    /m_want_more - Хотите больше? Получайте привелегии \
    став консультантом и бизнес-партнёром
    /m_get_gift - Получить подарок
    """
    await bot.sendMessage chatId, message

  bot.onText /\/m_feature/, (msg) ->
    chatId = msg.chat.id
    message = "Интересный, цепляющий текст"
    await bot.sendMessage chatId, message

  bot.onText /\/m_directions/, (msg) ->
    chatId = msg.chat.id
    message =
      "Все разделы: Фото - описание - \
      ссылка на сайте с диплинком, чтобы из инсты не выходить."
    await bot.sendMessage chatId, message

  bot.onText /\/m_what_people_are_saying/, (msg) ->
    chatId = msg.chat.id
    message = "Интересный, цепляющий текст"
    await bot.sendMessage chatId, message

  bot.onText /\/m_what_people_are_saying/, (msg) ->
    chatId = msg.chat.id
    message = "Что говорят о Вашей продукции клиенты?"
    await bot.sendMessage chatId, message

  bot.onText /\/m_where_to_look/, (msg) ->
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
    await bot.sendMessage chatId, message
    await bot.sendMessage chatId, "/main_menu - назад"

  bot.onText /\/m_how_to_get/, (msg) ->
    chatId = msg.chat.id
    message = """Заказ можно получить несколькими способами: \
      Самовывоз из бутиков TianDe, Самовывоз из пунктов выдачи, \
      Адресная доставка, Наложенным платежом.
      Адреса бутиков Вы сможете узнать в \
      приложении после регистрации, либо запросить у менеджеров @xxx
      
      /main_menu - назад
      """
    await bot.sendMessage chatId, message

  bot.onText /\/m_want_more/, (msg) ->
    chatId = msg.chat.id
    message = """
    Вы можете получать дополнительный доход, \
    получать скидки и привилегии или же построить полноценный бизнес с Tiande

    /what_is_business_with_tian_de - Что такое Бизнес с TianDe?
    """
    await bot.sendMessage chatId, message

  bot.onText /\/what_is_business_with_tian_de/, (msg) ->
    chatId = msg.chat.id
    message = "Бизнес с TianDe - это..."
    await bot.sendMessage chatId, message

  bot.onText /\/m_get_gift/, (msg) ->
    chatId = msg.chat.id
    message = "Получение подарка инфо"
    await bot.sendMessage chatId, message
