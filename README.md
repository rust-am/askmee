# Приложение 'Askmee'

Приложение клон ask.fm, которое позволяет задавать вопросы пользователям, и собственно на них отвечать.

Данное приложение реализовано на языке Ruby 2.7.1 и Rails 6.0.3.4

### Запуск

1. Склонирует себе репозиторий:

```
$ git clone git@github.com:rust-am/askmee.git
```

Или просто скачайте и распакуйте в какую-нибудь папку.

2. Создайте файл ```.env``` в корне проекта

```
$ cd askmee
$ nano .env
```

Скопируйте содежимое:
```
RECAPTCHA_SITE_KEY = "site_key"
RECAPTCHA_SECRET_KEY = "secret_key"
```
где ```site_key``` и ```secret_key``` ключи для [recaptcha v2](https://developers.google.com/recaptcha/docs/display), которые нужно самостоятельно получить и вписать в .env файл

2. Установите гемы:

```
$ bundle
```

3. Создайте базу и прогоните миграции:

```
$ rails db:create
$ rails db:migrate
```

4. Запуск сервера:

```
$ bundle exec rails s
```

Так же рабочий вариант сайта можно посмотреть по ссылке [https://aaskmee.herokuapp.com](https://aaskmee.herokuapp.com)
