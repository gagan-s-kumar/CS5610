defmodule Tasktracker.TrackerTest do
  use Tasktracker.DataCase

  alias Tasktracker.Tracker

  describe "tasks" do
    alias Tasktracker.Tracker.Task

    @valid_attrs %{completed: true, description: "some description", duration: 42, title: "some title"}
    @update_attrs %{completed: false, description: "some updated description", duration: 43, title: "some updated title"}
    @invalid_attrs %{completed: nil, description: nil, duration: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Tracker.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Tracker.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Tracker.create_task(@valid_attrs)
      assert task.completed == true
      assert task.description == "some description"
      assert task.duration == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Tracker.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completed == false
      assert task.description == "some updated description"
      assert task.duration == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_task(task, @invalid_attrs)
      assert task == Tracker.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Tracker.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Tracker.change_task(task)
    end
  end

  describe "manages" do
    alias Tasktracker.Tracker.Manage

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def manage_fixture(attrs \\ %{}) do
      {:ok, manage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_manage()

      manage
    end

    test "list_manages/0 returns all manages" do
      manage = manage_fixture()
      assert Tracker.list_manages() == [manage]
    end

    test "get_manage!/1 returns the manage with given id" do
      manage = manage_fixture()
      assert Tracker.get_manage!(manage.id) == manage
    end

    test "create_manage/1 with valid data creates a manage" do
      assert {:ok, %Manage{} = manage} = Tracker.create_manage(@valid_attrs)
    end

    test "create_manage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_manage(@invalid_attrs)
    end

    test "update_manage/2 with valid data updates the manage" do
      manage = manage_fixture()
      assert {:ok, manage} = Tracker.update_manage(manage, @update_attrs)
      assert %Manage{} = manage
    end

    test "update_manage/2 with invalid data returns error changeset" do
      manage = manage_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_manage(manage, @invalid_attrs)
      assert manage == Tracker.get_manage!(manage.id)
    end

    test "delete_manage/1 deletes the manage" do
      manage = manage_fixture()
      assert {:ok, %Manage{}} = Tracker.delete_manage(manage)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_manage!(manage.id) end
    end

    test "change_manage/1 returns a manage changeset" do
      manage = manage_fixture()
      assert %Ecto.Changeset{} = Tracker.change_manage(manage)
    end
  end

  describe "timeblocks" do
    alias Tasktracker.Tracker.Timeblock

    @valid_attrs %{end_time: "some end_time", start_time: "some start_time"}
    @update_attrs %{end_time: "some updated end_time", start_time: "some updated start_time"}
    @invalid_attrs %{end_time: nil, start_time: nil}

    def timeblock_fixture(attrs \\ %{}) do
      {:ok, timeblock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_timeblock()

      timeblock
    end

    test "list_timeblocks/0 returns all timeblocks" do
      timeblock = timeblock_fixture()
      assert Tracker.list_timeblocks() == [timeblock]
    end

    test "get_timeblock!/1 returns the timeblock with given id" do
      timeblock = timeblock_fixture()
      assert Tracker.get_timeblock!(timeblock.id) == timeblock
    end

    test "create_timeblock/1 with valid data creates a timeblock" do
      assert {:ok, %Timeblock{} = timeblock} = Tracker.create_timeblock(@valid_attrs)
      assert timeblock.end_time == "some end_time"
      assert timeblock.start_time == "some start_time"
    end

    test "create_timeblock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_timeblock(@invalid_attrs)
    end

    test "update_timeblock/2 with valid data updates the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, timeblock} = Tracker.update_timeblock(timeblock, @update_attrs)
      assert %Timeblock{} = timeblock
      assert timeblock.end_time == "some updated end_time"
      assert timeblock.start_time == "some updated start_time"
    end

    test "update_timeblock/2 with invalid data returns error changeset" do
      timeblock = timeblock_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_timeblock(timeblock, @invalid_attrs)
      assert timeblock == Tracker.get_timeblock!(timeblock.id)
    end

    test "delete_timeblock/1 deletes the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, %Timeblock{}} = Tracker.delete_timeblock(timeblock)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_timeblock!(timeblock.id) end
    end

    test "change_timeblock/1 returns a timeblock changeset" do
      timeblock = timeblock_fixture()
      assert %Ecto.Changeset{} = Tracker.change_timeblock(timeblock)
    end
  end

  describe "timeblocks" do
    alias Tasktracker.Tracker.Timeblock

    @valid_attrs %{end_time: ~T[14:00:00.000000], start_time: ~T[14:00:00.000000]}
    @update_attrs %{end_time: ~T[15:01:01.000000], start_time: ~T[15:01:01.000000]}
    @invalid_attrs %{end_time: nil, start_time: nil}

    def timeblock_fixture(attrs \\ %{}) do
      {:ok, timeblock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_timeblock()

      timeblock
    end

    test "list_timeblocks/0 returns all timeblocks" do
      timeblock = timeblock_fixture()
      assert Tracker.list_timeblocks() == [timeblock]
    end

    test "get_timeblock!/1 returns the timeblock with given id" do
      timeblock = timeblock_fixture()
      assert Tracker.get_timeblock!(timeblock.id) == timeblock
    end

    test "create_timeblock/1 with valid data creates a timeblock" do
      assert {:ok, %Timeblock{} = timeblock} = Tracker.create_timeblock(@valid_attrs)
      assert timeblock.end_time == ~T[14:00:00.000000]
      assert timeblock.start_time == ~T[14:00:00.000000]
    end

    test "create_timeblock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_timeblock(@invalid_attrs)
    end

    test "update_timeblock/2 with valid data updates the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, timeblock} = Tracker.update_timeblock(timeblock, @update_attrs)
      assert %Timeblock{} = timeblock
      assert timeblock.end_time == ~T[15:01:01.000000]
      assert timeblock.start_time == ~T[15:01:01.000000]
    end

    test "update_timeblock/2 with invalid data returns error changeset" do
      timeblock = timeblock_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_timeblock(timeblock, @invalid_attrs)
      assert timeblock == Tracker.get_timeblock!(timeblock.id)
    end

    test "delete_timeblock/1 deletes the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, %Timeblock{}} = Tracker.delete_timeblock(timeblock)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_timeblock!(timeblock.id) end
    end

    test "change_timeblock/1 returns a timeblock changeset" do
      timeblock = timeblock_fixture()
      assert %Ecto.Changeset{} = Tracker.change_timeblock(timeblock)
    end
  end

  describe "timesblocks" do
    alias Tasktracker.Tracker.Timesblock

    @valid_attrs %{end_time: ~T[14:00:00.000000], start_time: ~T[14:00:00.000000]}
    @update_attrs %{end_time: ~T[15:01:01.000000], start_time: ~T[15:01:01.000000]}
    @invalid_attrs %{end_time: nil, start_time: nil}

    def timesblock_fixture(attrs \\ %{}) do
      {:ok, timesblock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_timesblock()

      timesblock
    end

    test "list_timesblocks/0 returns all timesblocks" do
      timesblock = timesblock_fixture()
      assert Tracker.list_timesblocks() == [timesblock]
    end

    test "get_timesblock!/1 returns the timesblock with given id" do
      timesblock = timesblock_fixture()
      assert Tracker.get_timesblock!(timesblock.id) == timesblock
    end

    test "create_timesblock/1 with valid data creates a timesblock" do
      assert {:ok, %Timesblock{} = timesblock} = Tracker.create_timesblock(@valid_attrs)
      assert timesblock.end_time == ~T[14:00:00.000000]
      assert timesblock.start_time == ~T[14:00:00.000000]
    end

    test "create_timesblock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_timesblock(@invalid_attrs)
    end

    test "update_timesblock/2 with valid data updates the timesblock" do
      timesblock = timesblock_fixture()
      assert {:ok, timesblock} = Tracker.update_timesblock(timesblock, @update_attrs)
      assert %Timesblock{} = timesblock
      assert timesblock.end_time == ~T[15:01:01.000000]
      assert timesblock.start_time == ~T[15:01:01.000000]
    end

    test "update_timesblock/2 with invalid data returns error changeset" do
      timesblock = timesblock_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_timesblock(timesblock, @invalid_attrs)
      assert timesblock == Tracker.get_timesblock!(timesblock.id)
    end

    test "delete_timesblock/1 deletes the timesblock" do
      timesblock = timesblock_fixture()
      assert {:ok, %Timesblock{}} = Tracker.delete_timesblock(timesblock)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_timesblock!(timesblock.id) end
    end

    test "change_timesblock/1 returns a timesblock changeset" do
      timesblock = timesblock_fixture()
      assert %Ecto.Changeset{} = Tracker.change_timesblock(timesblock)
    end
  end
end
