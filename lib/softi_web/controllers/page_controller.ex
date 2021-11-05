defmodule SoftiWeb.PageController do
  use SoftiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
