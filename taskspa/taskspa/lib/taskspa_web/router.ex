defmodule TaskspaWeb.Router do
  use TaskspaWeb, :router

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

  scope "/", TaskspaWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/workers", PageController, :index
    get "/jobs", PageController, :index
    get "/workers/:id", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", TaskspaWeb do
    pipe_through :api
    resources "/workers", WorkerController, except: [:new, :edit]
    resources "/jobs", JobController, except: [:new, :edit]
    post "/token", TokenController, :create
  end
end
