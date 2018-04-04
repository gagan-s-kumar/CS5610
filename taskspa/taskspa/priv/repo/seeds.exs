# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Taskspa.Repo.insert!(%Taskspa.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule Seeds do
  alias Taskspa.Repo
  alias Taskspa.Workers.Worker
  alias Taskspa.Jobs.Job

  def run do
    p = Comeonin.Argon2.hashpwsalt("password1")
    Repo.delete_all(Worker)
    a = Repo.insert!(%Worker{ name: "alice", email: "alice@gmail.com", password_hash: p })
    b = Repo.insert!(%Worker{ name: "bob", email: "bob@gmail.com", password_hash: p })
    c = Repo.insert!(%Worker{ name: "carol", email: "carol@gmail.com", password_hash: p })
    d = Repo.insert!(%Worker{ name: "dave", email: "dave@gmail.com", password_hash: p })

    Repo.delete_all(Job)
    Repo.insert!(%Job{ worker_id: a.id, title: "Alice Task", description: "Alice first", duration: 15, completed: false })
    Repo.insert!(%Job{ worker_id: b.id, title: "Bob Task", description: "Bob first", duration: 15, completed: true })
    Repo.insert!(%Job{ worker_id: b.id, title: "Bob Again", description: "Bob second", duration: 30, completed: false })
    Repo.insert!(%Job{ worker_id: c.id, title: "Carol Task", description: "Carol first", duration: 15, completed: false })
    Repo.insert!(%Job{ worker_id: d.id, title: "Dave Task", description: "Dave first", duration: 45, completed: false })
  end
end

Seeds.run
