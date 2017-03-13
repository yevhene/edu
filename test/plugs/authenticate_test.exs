defmodule Edu.Plugs.AuthenticateTest do
  use Edu.ConnCase

  setup do
    {:ok, session: insert(:session)}
  end

  test "user passed if correct token is present", %{session: session} do
    conn = build_conn()
    |> put_req_header("authorization", "Bearer #{session.token}")
    |> Edu.Plugs.Authenticate.call(%{})

    assert conn.status != 401
    assert conn.assigns.session != nil
  end

  test "user not passed if no token present" do
    conn = build_conn()
    |> Edu.Plugs.Authenticate.call(%{})

    assert json_response(conn, 401)["errors"] != %{}
  end

  test "user not passed if wrong token present" do
    conn = build_conn()
    |> put_req_header("authorization", "Bearer wrong")
    |> Edu.Plugs.Authenticate.call(%{})

    assert json_response(conn, 401)["errors"] != %{}
  end
end
