defmodule Taskspa.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset


  schema "jobs" do
    field :completed, :boolean, default: false
    field :description, :string
    field :duration, :integer
    field :title, :string
    belongs_to :worker, Taskspa.Workers.Worker

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:title, :description, :duration, :completed])
    |> validate_required([:title, :description, :duration, :completed])
  end
end
