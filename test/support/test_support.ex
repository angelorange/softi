defmodule SoftiWeb.TestSuport do
  import Plug.Conn

  alias Softi.Guardian

  def login(conn, author) do
    {:ok, token, _claims} = Guardian.encode_and_sign(author)

    put_req_header(conn, "authorization", "Bearer #{token}")
  end
end
