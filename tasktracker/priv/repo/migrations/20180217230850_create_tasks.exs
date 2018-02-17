defmodule Tasktracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :duration, :integer, null: false
      add :completed, :boolean, default: false, null: false
      add :owner_id, references(:owners, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:tasks, [:owner_id])
  end
end
