defmodule Taskspa.Repo.Migrations.AddPasswordHashes do
  use Ecto.Migration

  def change do
    alter table("workers") do
      add :password_hash, :string
    end
  end
end

