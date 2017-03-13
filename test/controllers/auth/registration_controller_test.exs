defmodule Edu.Auth.RegistrationControllerTest do
  use Edu.ConnCase

  alias Edu.User

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  @tag :unauthorized
  describe "#create" do
    @valid_attrs %{email: "user@example.com", password: "password"}
    @invalid_attrs %{}

    test "creates resource when data is valid", %{conn: conn} do
      conn = post conn, auth_registration_path(conn, :create),
        registration: @valid_attrs
      id = json_response(conn, 201)["data"]["id"]

      assert id
      assert Repo.get(User, id)
    end

    test "does not create resource when data is invalid", %{conn: conn} do
      conn = post conn, auth_registration_path(conn, :create),
        registration: @invalid_attrs

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "#show" do
    test "shows chosen resource", %{conn: conn, session: %{user: user}} do
      conn = get conn, auth_registration_path(conn, :show)

      assert json_response(conn, 200)["data"] == %{
        "id" => user.id,
        "email" => user.email,
        "inserted_at" => DateTime.to_iso8601(user.inserted_at),
        "updated_at" => DateTime.to_iso8601(user.updated_at)
      }
    end
  end

  describe "#update" do
    @valid_attrs %{email: "newemail@example.com"}
    @invalid_attrs %{email: nil}

    test "updates resource when data is valid", %{
      conn: conn, session: %{user: user}
    } do
      conn = put conn, auth_registration_path(conn, :update),
        registration: @valid_attrs

      assert json_response(conn, 200)["data"]["id"] == user.id
      assert Repo.get_by(User, @valid_attrs)
    end

    test "does not update resource when data is invalid", %{conn: conn} do
      conn = put conn, auth_registration_path(conn, :update),
        registration: @invalid_attrs

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "#delete" do
    test "deletes chosen resource", %{conn: conn, session: %{user: user}} do
      conn = delete conn, auth_registration_path(conn, :delete)

      assert response(conn, 204)
      refute Repo.get(User, user.id)
    end
  end
end
