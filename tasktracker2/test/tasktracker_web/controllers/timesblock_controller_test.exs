defmodule TasktrackerWeb.TimesblockControllerTest do
  use TasktrackerWeb.ConnCase

  alias Tasktracker.Tracker
  alias Tasktracker.Tracker.Timesblock

  @create_attrs %{end_time: ~T[14:00:00.000000], start_time: ~T[14:00:00.000000]}
  @update_attrs %{end_time: ~T[15:01:01.000000], start_time: ~T[15:01:01.000000]}
  @invalid_attrs %{end_time: nil, start_time: nil}

  def fixture(:timesblock) do
    {:ok, timesblock} = Tracker.create_timesblock(@create_attrs)
    timesblock
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all timesblocks", %{conn: conn} do
      conn = get conn, timesblock_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create timesblock" do
    test "renders timesblock when data is valid", %{conn: conn} do
      conn = post conn, timesblock_path(conn, :create), timesblock: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, timesblock_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end_time" => ~T[14:00:00.000000],
        "start_time" => ~T[14:00:00.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, timesblock_path(conn, :create), timesblock: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update timesblock" do
    setup [:create_timesblock]

    test "renders timesblock when data is valid", %{conn: conn, timesblock: %Timesblock{id: id} = timesblock} do
      conn = put conn, timesblock_path(conn, :update, timesblock), timesblock: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, timesblock_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end_time" => ~T[15:01:01.000000],
        "start_time" => ~T[15:01:01.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn, timesblock: timesblock} do
      conn = put conn, timesblock_path(conn, :update, timesblock), timesblock: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete timesblock" do
    setup [:create_timesblock]

    test "deletes chosen timesblock", %{conn: conn, timesblock: timesblock} do
      conn = delete conn, timesblock_path(conn, :delete, timesblock)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, timesblock_path(conn, :show, timesblock)
      end
    end
  end

  defp create_timesblock(_) do
    timesblock = fixture(:timesblock)
    {:ok, timesblock: timesblock}
  end
end
