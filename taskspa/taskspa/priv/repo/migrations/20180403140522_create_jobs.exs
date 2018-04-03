defmodule Taskspa.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :title, :text
      add :description, :text
      add :duration, :integer
      add :completed, :boolean, default: false, null: false
      add :worker_id, references(:workers, on_delete: :nothing)

      timestamps()
    end

    create index(:jobs, [:worker_id])
  end
end
