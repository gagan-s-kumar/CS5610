defmodule Tasktracker.Logins.Owner do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Logins.Owner


  schema "owners" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Owner{} = owner, attrs) do
    owner
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
  end
end
