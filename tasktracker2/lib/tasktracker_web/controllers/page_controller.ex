defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    tasks = Enum.reverse(Tasktracker.Tracker.feed_tasks_for(conn.assigns[:current_owner]))   

    changeset = Tasktracker.Tracker.change_task(%Tasktracker.Tracker.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end
end
