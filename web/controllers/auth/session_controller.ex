defmodule Edu.Auth.SessionController do
  use Edu.Web, :controller

  plug :put_view, Edu.SessionView

  alias Edu.Session

  def create(conn, %{"session" => session_params}) do
    changeset = Session.changeset(%Session{}, session_params)

    case Repo.insert(changeset) do
      {:ok, session} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", auth_session_path(conn, :show))
        |> render("show.json", session: session)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Edu.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, _params) do
    render(conn, "show.json", session: conn.assigns.session)
  end

  def delete(conn, _params) do
    Repo.delete!(conn.assigns.session)

    send_resp(conn, :no_content, "")
  end
end
