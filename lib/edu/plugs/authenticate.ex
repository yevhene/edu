defmodule Edu.Plugs.Authenticate do
  import Plug.Conn

  alias Edu.Repo
  alias Edu.Session

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    case conn |> get_token do
      "Bearer " <> token ->
        session = Repo.get_by(Session, token: token) |> Repo.preload(:user)

        if session do
          conn |> assign(:session, session)
        else
          conn |> error
        end
      _ ->
        conn |> error
    end
  end

  defp get_token(conn) do
    conn
    |> get_req_header("authorization")
    |> List.first
  end

  defp error(conn) do
    conn
    |> put_status(:unauthorized)
    |> Phoenix.Controller.render(Edu.ErrorView, "401.json")
    |> halt
  end
end
