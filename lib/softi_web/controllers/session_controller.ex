defmodule SoftiWeb.SessionController do
  use SoftiWeb, :controller

  alias Softi.Accounts
  alias Softi.Guardian

  action_fallback SoftiWeb.FallbackController

  def login(conn, params) do
    with {:ok, author} <- Accounts.login(params),
         {:ok, token, _claims} = Guardian.encode_and_sign(author) do
      json(conn, %{token: token})
    end
  end
end
