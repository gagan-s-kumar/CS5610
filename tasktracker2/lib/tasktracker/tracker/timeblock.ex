defmodule Tasktracker.Tracker.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Tracker.Timeblock


  schema "timeblocks" do
    field :end_time, :time
    field :start_time, :time
    field :task_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start_time, :end_time])
    |> validate_required([:start_time, :end_time])
  end
end
