defmodule Edu.CoordinatorControllerTest do
  use Edu.ConnCase

  alias Edu.Coordinator
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, coordinator_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    coordinator = Repo.insert! %Coordinator{}
    conn = get conn, coordinator_path(conn, :show, coordinator)
    assert json_response(conn, 200)["data"] == %{"id" => coordinator.id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, coordinator_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, coordinator_path(conn, :create), coordinator: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Coordinator, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, coordinator_path(conn, :create), coordinator: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    coordinator = Repo.insert! %Coordinator{}
    conn = put conn, coordinator_path(conn, :update, coordinator), coordinator: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Coordinator, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    coordinator = Repo.insert! %Coordinator{}
    conn = put conn, coordinator_path(conn, :update, coordinator), coordinator: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    coordinator = Repo.insert! %Coordinator{}
    conn = delete conn, coordinator_path(conn, :delete, coordinator)
    assert response(conn, 204)
    refute Repo.get(Coordinator, coordinator.id)
  end
end
