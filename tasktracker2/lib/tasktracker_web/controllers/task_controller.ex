defmodule TasktrackerWeb.TaskController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Tracker
  alias Tasktracker.Tracker.Task
  alias Tasktracker.Logins

  def index(conn, _params) do
    tasks = Tracker.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Tracker.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    #owners = Logins.list_owners()
    current_owner = conn.assigns[:current_owner]
    #IO.inspect("Printing in create task")
    #IO.inspect current_owner
    managees = Logins.get_managees(current_owner.id)
    managees = Enum.map(managees, fn(x) -> Logins.get_owner!(elem(x, 0)) end)
    IO.inspect("Printing managees")
    IO.inspect managees
    managees_ids = Enum.map(managees, fn(x) -> x.id end)
    IO.inspect("Printing managees_ids")
    IO.inspect managees_ids
    case Tracker.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, managees_ids: managees_ids)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tracker.get_task!(id)
    current_owner = conn.assigns[:current_owner]
    IO.inspect("Printing in show task")
    #timesblocks = Tasktracker.Tracker.timesblocks_map_for(task.id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tracker.get_task!(id)
    changeset = Tracker.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tracker.get_task!(id)

    case Tracker.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tracker.get_task!(id)
    {:ok, _task} = Tracker.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
