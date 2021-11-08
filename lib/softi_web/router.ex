defmodule SoftiWeb.Router do
  use SoftiWeb, :router

  alias SoftiWeb.AuthorController
  alias SoftiWeb.SessionController

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SoftiWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    resources "/authors", AuthorController, except: [:new, :edit]
    post "/login", SessionController, :login
  end
end
