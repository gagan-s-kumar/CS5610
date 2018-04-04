defmodule Taskspa.Workers.Worker do
  use Ecto.Schema
  import Ecto.Changeset


  schema "workers" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(worker, attrs) do
    worker
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email])
  end
end
