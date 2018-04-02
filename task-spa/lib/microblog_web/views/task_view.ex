defmodule MicroblogWeb.TaskView do
  use MicroblogWeb, :view
  alias MicroblogWeb.TaskView
  alias MicroblogWeb.UserView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{id: task.id,
      title: task.title,
      description: task.description,
      duration: task.duration,
      completed: task.completed,
      user: render_one(task.user, UserView, "user.json")}
  end
end
