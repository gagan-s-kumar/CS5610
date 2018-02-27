defmodule Tasktracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :start_time, :string
      add :end_time, :string
      add :task_id, references(:tasks, on_delete: :delete_all)

      timestamps()
    end

    create index(:timeblocks, [:task_id])
  end
end
