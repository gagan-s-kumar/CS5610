defmodule TasktrackerWeb.OwnerController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Logins
  alias Tasktracker.Logins.Owner

  def index(conn, _params) do
    current_owner = conn.assigns[:current_owner]
    owners = Logins.list_owners()
    manages = Tasktracker.Tracker.manages_map_for(current_owner.id)
    render(conn, "index.html", owners: owners, manages: manages)
  end

  def new(conn, _params) do
    changeset = Logins.change_owner(%Owner{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"owner" => owner_params}) do
    case Logins.create_owner(owner_params) do
      {:ok, owner} ->
        conn
        |> put_flash(:info, "Owner created successfully.")
        |> redirect(to: owner_path(conn, :show, owner))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    owner = Logins.get_owner!(id)
    render(conn, "show.html", owner: owner)
  end

  def edit(conn, %{"id" => id}) do
    owner = Logins.get_owner!(id)
    changeset = Logins.change_owner(owner)
    render(conn, "edit.html", owner: owner, changeset: changeset)
  end

  def update(conn, %{"id" => id, "owner" => owner_params}) do
    owner = Logins.get_owner!(id)

    case Logins.update_owner(owner, owner_params) do
      {:ok, owner} ->
        conn
        |> put_flash(:info, "Owner updated successfully.")
        |> redirect(to: owner_path(conn, :show, owner))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", owner: owner, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    owner = Logins.get_owner!(id)
    {:ok, _owner} = Logins.delete_owner(owner)

    conn
    |> put_flash(:info, "Owner deleted successfully.")
    |> redirect(to: owner_path(conn, :index))
  end
end
