defmodule Edu.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      alias Edu.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Edu.Factory

      import Edu.Router.Helpers

      # The default endpoint for testing
      @endpoint Edu.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Edu.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Edu.Repo, {:shared, self()})
    end

    conn = Phoenix.ConnTest.build_conn()
    params = []

    {conn, params} = unauthorized(conn, tags, params)

    params = params ++ [conn: conn]
    {:ok, params}
  end

  defp unauthorized(conn, tags, params) do
    if !tags[:unauthorized] do
      session = Edu.Factory.insert(:session)
      params = params ++ [session: session]
      conn = conn |>
        Plug.Conn.put_req_header("authorization", "Bearer #{session.token}")
      {conn, params}
    else
      {conn, params}
    end
  end
end
