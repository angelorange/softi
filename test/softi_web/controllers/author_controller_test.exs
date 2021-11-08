defmodule SoftiWeb.AuthorControllerTest do
  use SoftiWeb.ConnCase

  alias Softi.Accounts.Author

  import Softi.AccountsFixtures
  import Softi.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all authors", %{conn: conn} do
      conn = get(conn, Routes.author_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create author" do
    test "renders author when data is valid", %{conn: conn} do
      author = params_for(:author)
      params = %{
        "author" => %{
          name: author.name,
          email: author.email,
          password: author.password
        }
      }

      conn = post(conn, Routes.author_path(conn, :create), params)

      assert expected = json_response(conn, 201)["data"]
      assert expected["name"] == author.name
      assert expected["email"] == author.email
      assert expected["password"] == author.password
    end

    test "renders errors when data is invalid", %{conn: conn} do
      params = %{
        email: nil,
        name: nil,
        password: nil
      }
      conn = post(conn, Routes.author_path(conn, :create), author: params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update author" do
    setup [:create_author]

    test "renders author when data is valid", %{conn: conn, author: %Author{id: id} = author} do
      params = %{
        id: id,
        name: author.name,
        email: author.email,
        password: author.password
      }
      conn = put(conn, Routes.author_path(conn, :update, author), author: params)

      assert expected = json_response(conn, 200)["data"]
      assert expected["email"] == params.email
      assert expected["name"] == params.name
      assert expected["password"] == params.password
    end
  end

  describe "delete author" do
    setup [:create_author]

    test "deletes chosen author", %{conn: conn, author: author} do
      conn = delete(conn, Routes.author_path(conn, :delete, author))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.author_path(conn, :show, author))
      end
    end
  end

  defp create_author(_) do
    author = insert(:author)
    %{author: author}
  end
end
