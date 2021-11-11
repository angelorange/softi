defmodule Softi.SessionControllerTest do
  use SoftiWeb.ConnCase

  import Softi.Factory

  setup %{conn: conn} do
    author = insert(:author)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), author: author}
  end

  describe "login" do
    test "with valid params, returns :ok", %{conn: conn, author: author} do
      params = %{email: author.email, password: author.password}

      conn = post(conn, Routes.session_path(conn, :login), params)

      assert json_response(conn, 200)["token"] =~ "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9."
    end

    test "with invalid password, returns :error", %{conn: conn, author: author} do
      params = %{email: author.email, password: "#{author.password}error"}

      conn = post(conn, Routes.session_path(conn, :login), params)

      assert json_response(conn, 404)
    end
  end
end
