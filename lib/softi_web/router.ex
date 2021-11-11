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

  pipeline :auth do
    plug :accepts, ["json"]
    plug SoftiWeb.AuthPlug
  end

  scope "/api" do
    pipe_through :api

    post "/login", SessionController, :login

    resources "/authors", AuthorController, except: [:new, :edit, :update]
    resources "/events", SoftiWeb.EventController, only: [:index, :show]
  end

  scope "/api" do
    pipe_through :auth

    resources "/authors", AuthorController, only: [:update]
    resources "/events", SoftiWeb.EventController, only: [:create, :update]
  end
end
