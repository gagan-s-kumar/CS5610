defmodule Tasktracker.Tracker.Timesblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Tracker.Timesblock
  alias Tasktracker.Tracker.Task


  schema "timesblocks" do
    field :end_time, :time
    field :start_time, :time
    belongs_to :task_id, Task

    timestamps()
  end

  @doc false
  def changeset(%Timesblock{} = timesblock, attrs) do
    timesblock
    |> cast(attrs, [:start_time, :end_time, :task_id])
    |> validate_required([:start_time, :end_time, :task_id])
  end
end
