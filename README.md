# Softi
O desafio é desenvolver uma API REST em Elixir, utilizando Phoenix, para geração de
anais (proceedings) de artigos científicos submetidos a eventos. Além da geração dos
anais, a aplicação deve permitir a inclusão, edição, visualização e exclusão de eventos e
artigos.

## Deps for Linux

- `sudo apt update`
- `sudo apt upgrade`
- `sudo apt install -y build-essential libssl-dev zlib1g-dev automake autoconf libncurses5-dev wkhtmltopdf`

## In loco Setup

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`
- Run complete tests `mix test`
- Full setup can be done too usign: `mix setup`
## Database
  PostgreSQL
  ```
  username: postgres
  password: postgres
  ```

## Using

 You can use postman, or a similar app, to send json to this API.The endpoint are below.

# Endpoints

 - Login ( post /api/login ) [returns a jwt]
  ```
  {
    "email": "algus@mail.com",
    "password": "somepassword"
  }
  ```

 - Add authors ( post /api/authors )
  ```
  {
    "author": {
      "email": "YOURMAIL@mail.com",
      "password": "somepassword",
      "name": "YOUR NAME"
    }
  }
  ```

 - Create Events ( post /api/events ) [needs Bearer Token]
  ```
  {
    "event": {
      "title": "Event I",
      "description": "Evento realizado ..."
    }
  }
  ```