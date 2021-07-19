fs = require "fs"
path = require "path"
user = require "./functions/user"
settings = require "./settings"
base = require "./functions/base"

module.exports = (bot) ->
  get_contact_settings = (mess) ->
    return
      reply_markup:
        keyboard: [[text: mess, request_contact: true]]

  bot.onText /\/start/, (msg) -> start msg
  bot.onText /\/main_menu/, (msg) -> main msg

  bot.onText /\/m_feature/, (msg) -> m_feature msg
  bot.onText /\/m_directions/, (msg) -> m_directions msg
  bot.onText /\/m_where_to_look/, (msg) -> m_where_to_look msg
  bot.onText /\/m_how_to_get/, (msg) -> m_how_to_get msg
  bot.onText /\/m_want_more/, (msg) -> m_want_more msg
  bot.onText /\/wm_step_1/, (msg) -> wm_step_1 msg
  bot.onText /\/m_get_gift/, (msg) ->
    m_get_gift msg

  bot.onText /\/wm_step_1/, (msg) -> wm_step_1 msg
  bot.onText /\/wm_step_2/, (msg) -> wm_step_2 msg
  bot.onText /\/wm_step_3/, (msg) -> wm_step_3 msg
  bot.onText /\/wm_step_4/, (msg) -> wm_step_4 msg
  bot.onText /\/wm_step_5/, (msg) -> wm_step_5 msg
  bot.onText /\/wm_step_6/, (msg) -> wm_step_6 msg
  bot.onText /\/wm_step_7/, (msg) -> wm_step_7 msg
  bot.onText /\/wm_step_8/, (msg) -> wm_step_8 msg
  bot.onText /\/wm_step_9/, (msg) -> wm_step_9 msg

  start = (msg) ->
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
            callback_data: "/review_page_1"
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

  bot.on "callback_query", (query) ->
    msg = query.message
    switch query.data
      when "/m_feature" then m_feature msg
      when "/m_directions" then m_directions msg
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
    message = "Просто написать нам сюда: @tiandeapp_bot"
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
            callback_data: "/wm_step_1"
          ]
        ]
    await bot.sendMessage chatId, message, settings

  m_get_gift = (msg) ->
    chatId = msg.chat.id
    message = "Получение подарка инфо"
    await bot.sendMessage chatId, message

  bot.on "callback_query", (query) ->
    msg = query.message
    switch query.data
      when "/wm_step_1" then wm_step_1 msg
      when "/wm_step_2" then wm_step_2 msg
      when "/wm_step_3" then wm_step_3 msg
      when "/wm_step_4" then wm_step_4 msg
      when "/wm_step_5" then wm_step_5 msg
      when "/wm_step_6" then wm_step_6 msg
      when "/wm_step_7" then wm_step_7 msg
      when "/wm_step_8" then wm_step_8 msg
      when "/wm_step_9" then wm_step_9 msg

  wm_stpep_settings = (step, text) ->
    return
      reply_markup:
        inline_keyboard: [
          [
            text: text
            callback_data: "/wm_step_" + step
          ]
        ]

  wm_step_1 = (msg) ->
    chatId = msg.chat.id
    message = "step_1"
    settings = wm_stpep_settings 2, "Бизнес с TianDe - это..."
    await bot.sendMessage chatId, message, settings

  wm_step_2 = (msg) ->
    chatId = msg.chat.id
    message = "step_2"
    settings = wm_stpep_settings 3, "Привелегии"
    await bot.sendMessage chatId, message, settings

  wm_step_3 = (msg) ->
    chatId = msg.chat.id
    message = "step_3"
    settings = wm_stpep_settings 4, "Что нужно делать"
    await bot.sendMessage chatId, message, settings

  wm_step_4 = (msg) ->
    chatId = msg.chat.id
    message = "step_4"
    settings = wm_stpep_settings 5, "Сколько можно зарабатывать?"
    await bot.sendMessage chatId, message, settings

  wm_step_5 = (msg) ->
    chatId = msg.chat.id
    message = "step_5"
    settings = wm_stpep_settings 6, "Реальные истории, Кейсы"
    await bot.sendMessage chatId, message, settings

  wm_step_6 = (msg) ->
    chatId = msg.chat.id
    message = "step_6"
    settings = wm_stpep_settings 7, "Возможности маштабироваться"
    await bot.sendMessage chatId, message, settings

  wm_step_7 = (msg) ->
    chatId = msg.chat.id
    message = "step_7"
    settings = wm_stpep_settings 8, "Как начать?"
    await bot.sendMessage chatId, message, settings

  wm_step_8 = (msg) ->
    chatId = msg.chat.id
    message = "step_8"
    settings = wm_stpep_settings 9, "Пошаговая стратегия"
    await bot.sendMessage chatId, message, settings

  wm_step_9 = (msg) ->
    chatId = msg.chat.id
    message = "step_9"
    await bot.sendMessage chatId, message

  bot.on "callback_query", (query) ->
    msg = query.message
    match = /^\/review_page_([0-9])+$/g.exec query.data.trim()
    if match && match.length > 0 && Number match[1]
      review_page msg, Number match[1]

  review_page = (msg, page = 1) ->
    chatId = msg.chat.id
    image_path = "./images/review/"
    count_images = 3

    settings =
      reply_markup:
        inline_keyboard: [
          [
            text: "Назад"
            callback_data: "/main_menu"
          ,
            text: "Еще"
            callback_data: "/review_page_" + (page + 1)
          ]
        ]

    files = fs.readdirSync image_path
    images = files.filter (file) -> /.*\.(gif|jpe?g|bmp|png)$/gim.test file
    images = images.slice (page - 1) * count_images, page * count_images
    images = images.map (image) ->
      fs.readFileSync path.resolve image_path, image
    if images.length > 0
      for image in images
        if --count_images
          await bot.sendPhoto chatId, image
          await base.time_out 1000
        else
          await bot.sendPhoto chatId, image, settings
    else
      message = """
      Читайте отзывы о нашей продукции во всех соцсетях:
      Ссылки на De_Отзыв
      Instagram: https://www.instagram.com/explore/tags/de_%\
      D0%BE%D1%82%D0%B7%D1%8B%D0%B2/
      VK: https://vk.com/feed?q=%23De_%D0%BE%D1%82%D0%B7%D1%8B%D0%B2§ion=search
      """
      await bot.sendMessage chatId, message,
        reply_markup:
          inline_keyboard: [[text: "Назад", callback_data: "/main_menu"]]
