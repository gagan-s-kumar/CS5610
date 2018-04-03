defmodule TaskspaWeb.JobView do
  use TaskspaWeb, :view
  alias TaskspaWeb.JobView
  alias TaskspaWeb.WorkerView

  def render("index.json", %{jobs: jobs}) do
    %{data: render_many(jobs, JobView, "job.json")}
  end

  def render("show.json", %{job: job}) do
    %{data: render_one(job, JobView, "job.json")}
  end

  def render("job.json", %{job: job}) do
    %{id: job.id,
      title: job.title,
      description: job.description,
      duration: job.duration,
      completed: job.completed,
      worker: render_one(job.worker, WorkerView, "worker.json")}
  end
end
