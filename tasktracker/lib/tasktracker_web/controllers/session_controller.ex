defmodule TasktrackerWeb.SessionController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Logins
  alias Tasktracker.Logins.Owner

  def create(conn, %{"email" => email}) do
    owner = Logins.get_owner_by_email(email)
    if owner do
      conn
      |> put_session(:owner_id, owner.id)
      |> put_flash(:info, "Welcome back #{owner.name}")
      |> redirect(to: page_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Can't create session")
      |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:owner_id)
    |> put_flash(:info, "Logged out")
    |> redirect(to: page_path(conn, :index))
  end
end

