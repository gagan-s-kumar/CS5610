# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Microblog.Repo.insert!(%Microblog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule Seeds do
  alias Microblog.Repo
  alias Microblog.Users.User
  alias Microblog.Tasks.Task

  def run do
    Repo.delete_all(User)
    a = Repo.insert!(%User{ email: "alice@gmail.com", name: "alice" })
    b = Repo.insert!(%User{ email: "bob@gmail.com", name: "bob" })
    c = Repo.insert!(%User{ email: "carol@gmail.com", name: "carol" })
    d = Repo.insert!(%User{ email: "dave@gmail.com", name: "dave" })

    Repo.delete_all(Task)
    Repo.insert!(%Task{ user_id: a.id, title: "Alice", description: "Alice's job", duration: 15, completed: false })
    Repo.insert!(%Task{ user_id: b.id, title: "Bob", description: "Bob's job", duration: 15, completed: true })
    Repo.insert!(%Task{ user_id: b.id, title: "Bob", description: "Bob's job second", duration: 30, completed: false })
    Repo.insert!(%Task{ user_id: b.id, title: "Bob", description: "Bob's job third", duration: 15, completed: true })
    Repo.insert!(%Task{ user_id: c.id, title: "Carol", description: "Carol's job", duration: 15, completed: false })
    Repo.insert!(%Task{ user_id: d.id, title: "Dave", description: "Dave's job", duration: 45, completed: false })
  end
end

Seeds.run

