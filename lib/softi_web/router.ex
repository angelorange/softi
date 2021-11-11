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

    resources "/events", SoftiWeb.EventController, except: [:new, :edit]
  end

  pipeline :auth do
    plug :accepts, ["json"]
    plug SoftiWeb.AuthPlug
  end

  scope "/api" do
    pipe_through :api

    resources "/authors", AuthorController, except: [:new, :edit, :update]
    post "/login", SessionController, :login
  end

  scope "/api" do
    pipe_through :auth

    resources "/authors", AuthorController, only: [:update]
  end
end
