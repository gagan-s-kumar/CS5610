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
    has_many :timesblock_timesblocks, Timesblock, foreign_key: :task_id
    has_many :timesblock, through: [:timesblock_timesblocks, :task_id]

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :duration, :completed, :owner_id])
    |> validate_required([:title, :description, :duration, :completed, :owner_id])
    |> validate_change(:duration, fn :duration, duration ->
			if rem(duration, 15) == 0 do
				[]
			else
				[duration: "Duration should be 15 multiple"]
			end
		     end)
  end
end
