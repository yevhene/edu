defmodule Edu.UserControllerTest do
  use Edu.ConnCase

  alias Edu.User
  @valid_attrs %{email: "user@example.com", password: "password"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "#index" do
    test "lists all entries on index", %{conn: conn} do
      Repo.insert! User.changeset(%User{}, @valid_attrs)
      conn = get conn, user_path(conn, :index)

      assert length(json_response(conn, 200)["data"]) == 1
    end
  end

  describe "#show" do
    test "shows chosen resource", %{conn: conn} do
      user = Repo.insert! User.changeset(%User{}, @valid_attrs)
      conn = get conn, user_path(conn, :show, user)

      assert json_response(conn, 200)["data"] == %{
        "id" => user.id,
        "email" => user.email,
        "inserted_at" => DateTime.to_iso8601(user.inserted_at),
        "updated_at" => DateTime.to_iso8601(user.updated_at)
      }
    end

    test "renders page not found when id is nonexistent", %{conn: conn} do
      assert_error_sent 404, fn ->
        get conn, user_path(conn, :show, -1)
      end
    end
  end

  describe "#create" do
    test "creates resource when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @valid_attrs
      id = json_response(conn, 201)["data"]["id"]

      assert id
      assert Repo.get(User, id)
    end

    test "does not create resource when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "#update" do
    test "updates resource when data is valid", %{conn: conn} do
      user = Repo.insert! User.changeset(%User{}, @valid_attrs)
      new_valid_attrs = %{email: "newemail@example.com"}
      conn = put conn, user_path(conn, :update, user), user: new_valid_attrs

      assert json_response(conn, 200)["data"]["id"] == user.id
      assert Repo.get_by(User, new_valid_attrs)
    end

    test "does not update resource when data is invalid", %{conn: conn} do
      user = Repo.insert! User.changeset(%User{}, @valid_attrs)
      new_valid_attrs = %{email: nil}
      conn = put conn, user_path(conn, :update, user), user: new_valid_attrs

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "#delete" do
    test "deletes chosen resource", %{conn: conn} do
      user = Repo.insert! User.changeset(%User{}, @valid_attrs)
      conn = delete conn, user_path(conn, :delete, user)

      assert response(conn, 204)
      refute Repo.get(User, user.id)
    end
  end
end
