defmodule Tasktracker.Tracker.Timesblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Tracker.Timesblock


  schema "timesblocks" do
    field :end_time, :time
    field :start_time, :time
    field :task_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Timesblock{} = timesblock, attrs) do
    timesblock
    |> cast(attrs, [:start_time, :end_time])
    |> validate_required([:start_time, :end_time])
  end
end
