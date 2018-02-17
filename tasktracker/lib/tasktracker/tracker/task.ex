defmodule Tasktracker.Tracker.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Tracker.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :duration, :integer
    field :title, :string
    field :owner_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :duration, :completed])
    |> validate_required([:title, :description, :duration, :completed])
  end
end
