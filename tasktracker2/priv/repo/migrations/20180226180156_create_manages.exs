defmodule Tasktracker.Repo.Migrations.CreateManages do
  use Ecto.Migration

  def change do
    create table(:manages) do
      add :manager_id, references(:owners, on_delete: :delete_all)
      add :managee_id, references(:owners, on_delete: :delete_all)

      timestamps()
    end

    create index(:manages, [:manager_id])
    create index(:manages, [:managee_id])
  end
end
