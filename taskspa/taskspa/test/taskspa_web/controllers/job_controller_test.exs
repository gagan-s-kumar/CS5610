defmodule TaskspaWeb.JobControllerTest do
  use TaskspaWeb.ConnCase

  alias Taskspa.Jobs
  alias Taskspa.Jobs.Job

  @create_attrs %{completed: true, description: "some description", duration: 42, title: "some title"}
  @update_attrs %{completed: false, description: "some updated description", duration: 43, title: "some updated title"}
  @invalid_attrs %{completed: nil, description: nil, duration: nil, title: nil}

  def fixture(:job) do
    {:ok, job} = Jobs.create_job(@create_attrs)
    job
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all jobs", %{conn: conn} do
      conn = get conn, job_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create job" do
    test "renders job when data is valid", %{conn: conn} do
      conn = post conn, job_path(conn, :create), job: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, job_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "completed" => true,
        "description" => "some description",
        "duration" => 42,
        "title" => "some title"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, job_path(conn, :create), job: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update job" do
    setup [:create_job]

    test "renders job when data is valid", %{conn: conn, job: %Job{id: id} = job} do
      conn = put conn, job_path(conn, :update, job), job: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, job_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "completed" => false,
        "description" => "some updated description",
        "duration" => 43,
        "title" => "some updated title"}
    end

    test "renders errors when data is invalid", %{conn: conn, job: job} do
      conn = put conn, job_path(conn, :update, job), job: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete job" do
    setup [:create_job]

    test "deletes chosen job", %{conn: conn, job: job} do
      conn = delete conn, job_path(conn, :delete, job)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, job_path(conn, :show, job)
      end
    end
  end

  defp create_job(_) do
    job = fixture(:job)
    {:ok, job: job}
  end
end
