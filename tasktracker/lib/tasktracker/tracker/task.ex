defmodule Tasktracker.Tracker.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Tracker.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :duration, :integer
    field :title, :string
    belongs_to :owner, Tasktracker.Logins.Owner

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :duration, :completed, :owner_id])
    |> validate_required([:title, :description, :duration, :completed, :owner_id])
  end
end
