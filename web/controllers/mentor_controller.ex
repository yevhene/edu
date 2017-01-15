defmodule Edu.MentorController do
  use Edu.Web, :controller

  alias Edu.Mentor

  def index(conn, _params) do
    mentors = Repo.all(Mentor)
    render(conn, "index.json", mentors: mentors)
  end

  def create(conn, %{"mentor" => mentor_params}) do
    changeset = Mentor.changeset(%Mentor{}, mentor_params)

    case Repo.insert(changeset) do
      {:ok, mentor} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", mentor_path(conn, :show, mentor))
        |> render("show.json", mentor: mentor)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Edu.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    mentor = Repo.get!(Mentor, id)
    render(conn, "show.json", mentor: mentor)
  end

  def update(conn, %{"id" => id, "mentor" => mentor_params}) do
    mentor = Repo.get!(Mentor, id)
    changeset = Mentor.changeset(mentor, mentor_params)

    case Repo.update(changeset) do
      {:ok, mentor} ->
        render(conn, "show.json", mentor: mentor)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Edu.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    mentor = Repo.get!(Mentor, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(mentor)

    send_resp(conn, :no_content, "")
  end
end
