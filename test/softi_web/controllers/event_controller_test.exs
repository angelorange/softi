defmodule SoftiWeb.EventControllerTest do
  use SoftiWeb.ConnCase

  alias Softi.Proceedings.Event

  import Softi.Factory

  setup %{conn: conn} do
    author = insert(:author)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), author: author}
  end

  describe "index" do
    test "lists all events", %{conn: conn} do
      conn = get(conn, Routes.event_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create event" do
    test "renders event when data is valid, as Author", %{conn: conn} do
      author = insert(:author)
      params = %{
          title: "Idk",
          description: "kkkkkkkkkkkkkkk"
      }

      conn =
        login(conn, author)
        |> post(Routes.event_path(conn, :create), event: params)

      assert expected = json_response(conn, 201)["data"]
      assert expected["author_id"] == author.id
      assert expected["title"] == params.title
      assert expected["description"] == params.description
    end

    test "renders errors when data is invalid", %{conn: conn, author: author} do
      params = %{title: nil, description: nil}

      conn =
        login(conn, author)
        |> post(Routes.event_path(conn, :create), event: params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update event" do
    setup [:create_event]

    test "renders event when data is valid", %{conn: conn, event: event, author: author} do
      params = %{title: "Comer, rezar e amar", description: "nada demais aqui"}

      conn =
        login(conn, author)
        |> put(Routes.event_path(conn, :update, event), event: params)

      assert expected = json_response(conn, 200)["data"]
      assert expected["title"] == params.title
    end

    test "renders errors when data is invalid", %{conn: conn, event: event, author: author} do
      params = %{title: nil, description: nil}

      conn =
        login(conn, author)
        |> put(Routes.event_path(conn, :update, event), event: params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_event(_) do
    event = insert(:event)
    %{event: event}
  end
end
