defmodule Tasktracker.Repo.Migrations.CreateTimesblocks do
  use Ecto.Migration

  def change do
    create table(:timesblocks) do
      add :start_time, :time
      add :end_time, :time
      add :task_id, references(:tasks, on_delete: :delete_all)

      timestamps()
    end

    create index(:timesblocks, [:task_id])
  end
end
