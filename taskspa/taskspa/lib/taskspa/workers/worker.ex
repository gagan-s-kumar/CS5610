defmodule Taskspa.Workers.Worker do
  use Ecto.Schema
  import Ecto.Changeset


  schema "workers" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(worker, attrs) do
    worker
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
