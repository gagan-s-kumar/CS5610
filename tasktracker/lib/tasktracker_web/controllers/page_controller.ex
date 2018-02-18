defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    tasks = Tasktracker.Tracker.list_tasks()
    changeset = Tasktracker.Tracker.change_task(%Tasktracker.Tracker.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end
end
