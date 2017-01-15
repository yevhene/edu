defmodule Edu.MentorControllerTest do
  use Edu.ConnCase

  alias Edu.Mentor
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, mentor_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    mentor = Repo.insert! %Mentor{}
    conn = get conn, mentor_path(conn, :show, mentor)
    assert json_response(conn, 200)["data"] == %{"id" => mentor.id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, mentor_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, mentor_path(conn, :create), mentor: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Mentor, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, mentor_path(conn, :create), mentor: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    mentor = Repo.insert! %Mentor{}
    conn = put conn, mentor_path(conn, :update, mentor), mentor: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Mentor, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    mentor = Repo.insert! %Mentor{}
    conn = put conn, mentor_path(conn, :update, mentor), mentor: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    mentor = Repo.insert! %Mentor{}
    conn = delete conn, mentor_path(conn, :delete, mentor)
    assert response(conn, 204)
    refute Repo.get(Mentor, mentor.id)
  end
end
