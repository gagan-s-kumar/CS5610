defmodule Tasktracker.Tracker do
  @moduledoc """
  The Tracker context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.Tracker.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
    |> Repo.preload(:owner)
  end

  def feed_tasks_for(owner) do
   owner = Repo.preload(owner, :managees)
   managed_ids = Enum.map(owner.managees, &(&1.id))

    Repo.all(Task)
    |> Enum.filter(&(Enum.member?(managed_ids, &1.owner_id)))
    |> Repo.preload(:owner)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id) |> Repo.preload(:owner)

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

  alias Tasktracker.Tracker.Manage

  @doc """
  Returns the list of manages.

  ## Examples

      iex> list_manages()
      [%Manage{}, ...]

  """
  def list_manages do
    Repo.all(Manage)
  end

  @doc """
  Gets a single manage.

  Raises `Ecto.NoResultsError` if the Manage does not exist.

  ## Examples

      iex> get_manage!(123)
      %Manage{}

      iex> get_manage!(456)
      ** (Ecto.NoResultsError)

  """
  def get_manage!(id), do: Repo.get!(Manage, id)

  @doc """
  Creates a manage.

  ## Examples

      iex> create_manage(%{field: value})
      {:ok, %Manage{}}

      iex> create_manage(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_manage(attrs \\ %{}) do
    %Manage{}
    |> Manage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a manage.

  ## Examples

      iex> update_manage(manage, %{field: new_value})
      {:ok, %Manage{}}

      iex> update_manage(manage, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_manage(%Manage{} = manage, attrs) do
    manage
    |> Manage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Manage.

  ## Examples

      iex> delete_manage(manage)
      {:ok, %Manage{}}

      iex> delete_manage(manage)
      {:error, %Ecto.Changeset{}}

  """
  def delete_manage(%Manage{} = manage) do
    Repo.delete(manage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking manage changes.

  ## Examples

      iex> change_manage(manage)
      %Ecto.Changeset{source: %Manage{}}

  """
  def change_manage(%Manage{} = manage) do
    Manage.changeset(manage, %{})
  end

  def manages_map_for(owner_id) do
    Repo.all(from m in Manage,
      where: m.manager_id == ^owner_id)
    |> Enum.map(&({&1.managee_id, &1.id}))
    |> Enum.into(%{})
  end

  def timesblocks_map_for(task_id) do
    Repo.all(from t in Timesblock,
      where: t.task_id == ^task_id)
    |> Enum.map(&({&1.task_id, &1.id}))
    |> Enum.into(%{})
  end

  alias Tasktracker.Tracker.Timeblock

  @doc """
  Returns the list of timeblocks.

  ## Examples

      iex> list_timeblocks()
      [%Timeblock{}, ...]

  """
  def list_timeblocks do
    Repo.all(Timeblock)
  end

  @doc """
  Gets a single timeblock.

  Raises `Ecto.NoResultsError` if the Timeblock does not exist.

  ## Examples

      iex> get_timeblock!(123)
      %Timeblock{}

      iex> get_timeblock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timeblock!(id), do: Repo.get!(Timeblock, id)

  @doc """
  Creates a timeblock.

  ## Examples

      iex> create_timeblock(%{field: value})
      {:ok, %Timeblock{}}

      iex> create_timeblock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timeblock(attrs \\ %{}) do
    %Timeblock{}
    |> Timeblock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timeblock.

  ## Examples

      iex> update_timeblock(timeblock, %{field: new_value})
      {:ok, %Timeblock{}}

      iex> update_timeblock(timeblock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timeblock(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> Timeblock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Timeblock.

  ## Examples

      iex> delete_timeblock(timeblock)
      {:ok, %Timeblock{}}

      iex> delete_timeblock(timeblock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timeblock(%Timeblock{} = timeblock) do
    Repo.delete(timeblock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timeblock changes.

  ## Examples

      iex> change_timeblock(timeblock)
      %Ecto.Changeset{source: %Timeblock{}}

  """
  def change_timeblock(%Timeblock{} = timeblock) do
    Timeblock.changeset(timeblock, %{})
  end

  alias Tasktracker.Tracker.Timesblock

  @doc """
  Returns the list of timesblocks.

  ## Examples

      iex> list_timesblocks()
      [%Timesblock{}, ...]

  """
  def list_timesblocks do
    Repo.all(Timesblock)
  end

  @doc """
  Gets a single timesblock.

  Raises `Ecto.NoResultsError` if the Timesblock does not exist.

  ## Examples

      iex> get_timesblock!(123)
      %Timesblock{}

      iex> get_timesblock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timesblock!(id), do: Repo.get!(Timesblock, id)

  @doc """
  Creates a timesblock.

  ## Examples

      iex> create_timesblock(%{field: value})
      {:ok, %Timesblock{}}

      iex> create_timesblock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timesblock(attrs \\ %{}) do
    %Timesblock{}
    |> Timesblock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timesblock.

  ## Examples

      iex> update_timesblock(timesblock, %{field: new_value})
      {:ok, %Timesblock{}}

      iex> update_timesblock(timesblock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timesblock(%Timesblock{} = timesblock, attrs) do
    timesblock
    |> Timesblock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Timesblock.

  ## Examples

      iex> delete_timesblock(timesblock)
      {:ok, %Timesblock{}}

      iex> delete_timesblock(timesblock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timesblock(%Timesblock{} = timesblock) do
    Repo.delete(timesblock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timesblock changes.

  ## Examples

      iex> change_timesblock(timesblock)
      %Ecto.Changeset{source: %Timesblock{}}

  """
  def change_timesblock(%Timesblock{} = timesblock) do
    Timesblock.changeset(timesblock, %{})
  end
end
