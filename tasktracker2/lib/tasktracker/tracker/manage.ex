defmodule Tasktracker.Tracker.Manage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Tracker.Manage

  alias Tasktracker.Logins.Owner

  schema "manages" do
    belongs_to :manager, Owner
    belongs_to :managee, Owner

    timestamps()
  end

  @doc false
  def changeset(%Manage{} = manage, attrs) do
    manage
    |> cast(attrs, [:manager_id, :managee_id])
    |> validate_required([:manager_id, :managee_id])
  end
 
end
