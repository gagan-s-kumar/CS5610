defmodule Tasktracker.Tracker.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Tracker.Timeblock

  alias Tasktracker.Tracker.Task

  schema "timeblocks" do
    field :end_time, :string
    field :start_time, :string
    belongs_to :task_id, Task

    timestamps()
  end

  @doc false
  def changeset(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start_time, :end_time, :task_id])
    |> validate_required([:start_time, :end_time, :task_id])
  end
end
