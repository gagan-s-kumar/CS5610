defmodule TaskspaWeb.TokenController do
  use TaskspaWeb, :controller
  alias Taskspa.Workers.Worker

  action_fallback TaskspaWeb.FallbackController

  def create(conn, %{"name" => name, "pass" => pass}) do
    with {:ok, %Worker{} = worker} <- Taskspa.Workers.get_and_auth_worker(name, pass) do
      token = Phoenix.Token.sign(conn, "auth token", worker.id)
      conn
      |> put_status(:created)
      |> render("token.json", worker: worker, token: token)
    end
  end
end
