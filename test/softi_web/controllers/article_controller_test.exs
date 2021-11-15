defmodule SoftiWeb.ArticleControllerTest do
  use SoftiWeb.ConnCase

  alias Softi.Proceedings.Article

  import Softi.Factory

  setup %{conn: conn} do
    author = insert(:author)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), author: author}
  end

  describe "index" do
    test "lists all articles", %{conn: conn} do
      conn = get(conn, Routes.article_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create article" do
    test "renders article when data is valid, as Author", %{conn: conn} do
      author = insert(:author)
      event = insert(:event)

      params = %{
        title: "kiki",
        summary: "nao sei o q fazer aq",
        keywords: ["naosei"],
        author_id: author.id,
        event_id: event.id
      }

      conn =
        login(conn, author)
        |> post(Routes.article_path(conn, :create), article: params)

      assert expected = json_response(conn, 201)["data"]
      assert expected["author_id"] == author.id
      assert expected["title"] == params.title
    end

    test "renders errors when data is invalid", %{conn: conn, author: author} do
      params = %{title: nil, summary: nil, keywords: nil, author_id: nil, event_id: nil}

      conn =
        login(conn, author)
        |> post(Routes.article_path(conn, :create), article: params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update article" do

    test "renders event when data is valid", %{conn: conn} do
      author = insert(:author)
      event = insert(:event)
      article = insert(:article)
      params = %{title: "A morte do pop", summary: "pero pero pero pero pero", author_id: author.id, keywords: ["MJ"], event_id: event.id}

      conn =
        login(conn, author)
        |> put(Routes.article_path(conn, :update, article), article: params)

      assert expected = json_response(conn, 200)["data"]
      assert expected["title"] == params.title
    end

    test "renders errors when data is invalid", %{conn: conn} do
      article = insert(:article)
      params = %{title: nil, summary: nil, keywords: nil, event_id: nil, author_id: nil}
      event = insert(:event)
      author = insert(:author)

      conn =
        login(conn, author)
        |> put(Routes.article_path(conn, :update, article), article: params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
