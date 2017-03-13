defmodule Edu.Auth.SessionControllerTest do
  use Edu.ConnCase

  alias Edu.Session

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  @tag :unauthorized
  describe "#create" do
    setup %{conn: conn} do
      {:ok, conn: conn, user: insert(:user)}
    end

    test "creates resource when data is valid", %{conn: conn, user: user} do
      conn = post conn, auth_session_path(conn, :create), session: %{
        email: user.email, password: user.password
      }
      token = json_response(conn, 201)["data"]["token"]

      assert token
      assert Repo.get_by(Session, token: token)
    end

    test "does not create resource when data is invalid", %{conn: conn} do
      conn = post conn, auth_session_path(conn, :create), session: %{}

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "#show" do
    test "shows chosen resource", %{conn: conn, session: session} do
      conn = get conn, auth_session_path(conn, :show)

      assert json_response(conn, 200)["data"] == %{
        "id" => session.id,
        "token" => session.token,
        "user_id" => session.user_id,
        "inserted_at" => DateTime.to_iso8601(session.inserted_at),
        "updated_at" => DateTime.to_iso8601(session.updated_at)
      }
    end
  end

  describe "#delete" do
    test "deletes chosen resource", %{conn: conn, session: session} do
      conn = delete conn, auth_session_path(conn, :delete)

      assert response(conn, 204)
      refute Repo.get(Session, session.id)
    end
  end
end
