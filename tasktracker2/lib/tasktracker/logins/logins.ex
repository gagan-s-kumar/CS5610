defmodule Tasktracker.Logins do
  @moduledoc """
  The Logins context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.Logins.Owner

  alias Tasktracker.Tracker.Manage

  @doc """
  Returns the list of owners.

  ## Examples

      iex> list_owners()
      [%Owner{}, ...]

  """
  def list_owners do
    Repo.all(Owner)
  end

  @doc """
  Gets a single owner.

  Raises `Ecto.NoResultsError` if the Owner does not exist.

  ## Examples

      iex> get_owner!(123)
      %Owner{}

      iex> get_owner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_owner!(id), do: Repo.get!(Owner, id)

  def get_manager(owner_id) do
   manager = Repo.get_by(Manage, managee_id: owner_id)
   # Null check not happening, TODO
   if manager do
     get_owner(manager.manager_id)
   end
  end

  def get_managees1(owner_id) do
   managee = Repo.get_by(Manage, manager_id: owner_id)
   # Null check not happening, TODO
   if managee do
     [get_owner(managee.managee_id)]
   end
  end

  def get_managees(owner_id) do
   Repo.all(from m in Manage,
      where: m.manager_id == ^owner_id)
    |> Enum.map(&({&1.managee_id, &1.id}))
  end

  # We want a non-bang variant
  def get_owner(id), do: Repo.get(Owner, id)
 
  # And we want by-email lookup
  def get_owner_by_email(email) do
    Repo.get_by(Owner, email: email)
  end

  @doc """
  Creates a owner.

  ## Examples

      iex> create_owner(%{field: value})
      {:ok, %Owner{}}

      iex> create_owner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_owner(attrs \\ %{}) do
    %Owner{}
    |> Owner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a owner.

  ## Examples

      iex> update_owner(owner, %{field: new_value})
      {:ok, %Owner{}}

      iex> update_owner(owner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_owner(%Owner{} = owner, attrs) do
    owner
    |> Owner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Owner.

  ## Examples

      iex> delete_owner(owner)
      {:ok, %Owner{}}

      iex> delete_owner(owner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_owner(%Owner{} = owner) do
    Repo.delete(owner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking owner changes.

  ## Examples

      iex> change_owner(owner)
      %Ecto.Changeset{source: %Owner{}}

  """
  def change_owner(%Owner{} = owner) do
    Owner.changeset(owner, %{})
  end
end
