defmodule Edu.Auth.RegistrationController do
  use Edu.Web, :controller

  plug :put_view, Edu.UserView

  alias Edu.User

  def create(conn, %{"registration" => registration_params}) do
    changeset = User.create_registration_changeset(%User{}, registration_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", auth_registration_path(conn, :show))
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Edu.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, _params) do
    render(conn, "show.json", user: conn.assigns.session.user)
  end

  def update(conn, %{"registration" => registration_params}) do
    changeset = User.update_registration_changeset(
      conn.assigns.session.user, registration_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Edu.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    Repo.delete!(conn.assigns.session.user)

    send_resp(conn, :no_content, "")
  end
end
