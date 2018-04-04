defmodule TaskspaWeb.WorkerController do
  use TaskspaWeb, :controller

  alias Taskspa.Workers
  alias Taskspa.Workers.Worker

  action_fallback TaskspaWeb.FallbackController

  def index(conn, _params) do
    workers = Workers.list_workers()
    render(conn, "index.json", workers: workers)
  end

  def create(conn, %{"worker" => worker_params}) do
    IO.inspect("worker_params")
    IO.inspect(worker_params)
    password = worker_params["password"]
    password_hash = Comeonin.Argon2.hashpwsalt(password)
    worker_params = Map.put(worker_params, "password_hash", password_hash)
    IO.inspect("worker_params")
    IO.inspect(worker_params)
    with {:ok, %Worker{} = worker} <- Workers.create_worker(worker_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", worker_path(conn, :show, worker))
      |> render("show.json", worker: worker)
    end
  end

  def show(conn, %{"id" => id}) do
    worker = Workers.get_worker!(id)
    render(conn, "show.json", worker: worker)
  end

  def update(conn, %{"id" => id, "worker" => worker_params}) do
    worker = Workers.get_worker!(id)

    with {:ok, %Worker{} = worker} <- Workers.update_worker(worker, worker_params) do
      render(conn, "show.json", worker: worker)
    end
  end

  def delete(conn, %{"id" => id}) do
    worker = Workers.get_worker!(id)
    with {:ok, %Worker{}} <- Workers.delete_worker(worker) do
      send_resp(conn, :no_content, "")
    end
  end
end
