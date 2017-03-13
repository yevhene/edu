defmodule Edu.UserControllerTest do
  use Edu.ConnCase

  alias Edu.User

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "#index" do
    setup %{conn: conn} do
      {:ok, conn: conn, users: insert_list(3, :user)}
    end

    test "lists all entries on index", %{conn: conn, users: users} do
      conn = get conn, user_path(conn, :index)

      assert length(json_response(conn, 200)["data"]) == length(users)
    end
  end

  describe "#show" do
    setup %{conn: conn} do
      {:ok, conn: conn, user: insert(:user)}
    end

    test "shows chosen resource", %{conn: conn, user: user} do
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
    @valid_attrs %{email: "user@example.com", password: "password"}
    @invalid_attrs %{}

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
    setup %{conn: conn} do
      {:ok, conn: conn, user: insert(:user)}
    end

    @valid_attrs %{email: "newemail@example.com"}
    @invalid_attrs %{email: nil}

    test "updates resource when data is valid", %{conn: conn, user: user} do
      conn = put conn, user_path(conn, :update, user), user: @valid_attrs

      assert json_response(conn, 200)["data"]["id"] == user.id
      assert Repo.get_by(User, @valid_attrs)
    end

    test "does not update resource when data is invalid", %{
      conn: conn, user: user
    } do
      conn = put conn, user_path(conn, :update, user), user: @invalid_attrs

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "#delete" do
    setup %{conn: conn} do
      {:ok, conn: conn, user: insert(:user)}
    end

    test "deletes chosen resource", %{conn: conn, user: user} do
      conn = delete conn, user_path(conn, :delete, user)

      assert response(conn, 204)
      refute Repo.get(User, user.id)
    end
  end
end
