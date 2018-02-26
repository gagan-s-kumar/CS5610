defmodule Tasktracker.Repo.Migrations.CreateOwners do
  use Ecto.Migration

  def change do
    create table(:owners) do
      add :email, :string, null: false
      add :name, :string, null: false

      timestamps()
    end

  end
end
