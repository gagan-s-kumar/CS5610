defmodule JivifightWeb.Router do
  use JivifightWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JivifightWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/game/:game", PageController, :game
  end

  # Other scopes may use custom stacks.
  # scope "/api", JivifightWeb do
  #   pipe_through :api
  # end
end
