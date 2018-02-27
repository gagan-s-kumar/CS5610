defmodule TasktrackerWeb.TimesblockController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Tracker
  alias Tasktracker.Tracker.Timesblock

  action_fallback TasktrackerWeb.FallbackController

  def index(conn, _params) do
    timesblocks = Tracker.list_timesblocks()
    render(conn, "index.json", timesblocks: timesblocks)
  end

  def create(conn, %{"timesblock" => timesblock_params}) do
    with {:ok, %Timesblock{} = timesblock} <- Tracker.create_timesblock(timesblock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", timesblock_path(conn, :show, timesblock))
      |> render("show.json", timesblock: timesblock)
    end
  end

  def show(conn, %{"id" => id}) do
    timesblock = Tracker.get_timesblock!(id)
    render(conn, "show.json", timesblock: timesblock)
  end

  def update(conn, %{"id" => id, "timesblock" => timesblock_params}) do
    timesblock = Tracker.get_timesblock!(id)

    with {:ok, %Timesblock{} = timesblock} <- Tracker.update_timesblock(timesblock, timesblock_params) do
      render(conn, "show.json", timesblock: timesblock)
    end
  end

  def delete(conn, %{"id" => id}) do
    timesblock = Tracker.get_timesblock!(id)
    with {:ok, %Timesblock{}} <- Tracker.delete_timesblock(timesblock) do
      send_resp(conn, :no_content, "")
    end
  end
end
