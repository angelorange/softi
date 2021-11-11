defmodule SoftiWeb.EventController do
  use SoftiWeb, :controller

  alias Softi.Proceedings
  alias Softi.Proceedings.Event

  action_fallback SoftiWeb.FallbackController

  def index(conn, _params) do
    events = Proceedings.list_events()
    render(conn, "index.json", events: events)
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, %Event{} = event} <- Proceedings.create_event(event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.event_path(conn, :show, event))
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Proceedings.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Proceedings.get_event!(id)

    with {:ok, %Event{} = event} <- Proceedings.update_event(event, event_params) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Proceedings.get_event!(id)

    with {:ok, %Event{}} <- Proceedings.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
