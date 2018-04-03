defmodule Taskspa.JobsTest do
  use Taskspa.DataCase

  alias Taskspa.Jobs

  describe "jobs" do
    alias Taskspa.Jobs.Job

    @valid_attrs %{completed: true, description: "some description", duration: 42, title: "some title"}
    @update_attrs %{completed: false, description: "some updated description", duration: 43, title: "some updated title"}
    @invalid_attrs %{completed: nil, description: nil, duration: nil, title: nil}

    def job_fixture(attrs \\ %{}) do
      {:ok, job} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_job()

      job
    end

    test "list_jobs/0 returns all jobs" do
      job = job_fixture()
      assert Jobs.list_jobs() == [job]
    end

    test "get_job!/1 returns the job with given id" do
      job = job_fixture()
      assert Jobs.get_job!(job.id) == job
    end

    test "create_job/1 with valid data creates a job" do
      assert {:ok, %Job{} = job} = Jobs.create_job(@valid_attrs)
      assert job.completed == true
      assert job.description == "some description"
      assert job.duration == 42
      assert job.title == "some title"
    end

    test "create_job/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_job(@invalid_attrs)
    end

    test "update_job/2 with valid data updates the job" do
      job = job_fixture()
      assert {:ok, job} = Jobs.update_job(job, @update_attrs)
      assert %Job{} = job
      assert job.completed == false
      assert job.description == "some updated description"
      assert job.duration == 43
      assert job.title == "some updated title"
    end

    test "update_job/2 with invalid data returns error changeset" do
      job = job_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_job(job, @invalid_attrs)
      assert job == Jobs.get_job!(job.id)
    end

    test "delete_job/1 deletes the job" do
      job = job_fixture()
      assert {:ok, %Job{}} = Jobs.delete_job(job)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_job!(job.id) end
    end

    test "change_job/1 returns a job changeset" do
      job = job_fixture()
      assert %Ecto.Changeset{} = Jobs.change_job(job)
    end
  end
end
