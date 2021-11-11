defmodule SoftiWeb.EventControllerTest do
  use SoftiWeb.ConnCase

  alias Softi.Proceedings.Event

  import Softi.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all events", %{conn: conn} do
      conn = get(conn, Routes.event_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create event" do
    test "renders event when data is valid", %{conn: conn} do
      params = %{
        title: "Idk",
        description: "kkkkkkkkkkkkkkk"
      }
      conn = post(conn, Routes.event_path(conn, :create), event: params)

      assert expected = json_response(conn, 201)["data"]
      assert expected["title"] == params.title
      assert expected["description"] == params.description
    end

    test "renders errors when data is invalid", %{conn: conn} do
      params = %{title: nil, description: nil}

      conn = post(conn, Routes.event_path(conn, :create), event: params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update event" do
    setup [:create_event]

    test "renders event when data is valid", %{conn: conn, event: %Event{id: id} = event} do
      params = %{title: "Comer, rezar e amar", description: "nada demais aqui"}

      conn = put(conn, Routes.event_path(conn, :update, event), event: params)

      assert expected = json_response(conn, 200)["data"]
      assert expected["title"] == params.title
    end

    test "renders errors when data is invalid", %{conn: conn, event: event} do
      params = %{title: nil, description: nil}

      conn = put(conn, Routes.event_path(conn, :update, event), event: params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete event" do
    setup [:create_event]

    test "deletes chosen event", %{conn: conn, event: event} do
      conn = delete(conn, Routes.event_path(conn, :delete, event))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.event_path(conn, :show, event))
      end
    end
  end

  defp create_event(_) do
    event = insert(:event)
    %{event: event}
  end
end
