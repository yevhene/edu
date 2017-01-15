defmodule Edu.MentorController do
  use Edu.Web, :controller

  alias Edu.Mentor

  def index(conn, %{"group_id" => group_id}) do
    mentors = Repo.all from m in Mentor,
      where: m.group_id == ^group_id
    render(conn, "index.json", mentors: mentors)
  end

  def create(conn, %{"group_id" => group_id, "mentor" => mentor_params}) do
    params = Map.merge(mentor_params, %Mentor{group_id: group_id})
    changeset = Mentor.changeset(%Mentor{}, params)

    case Repo.insert(changeset) do
      {:ok, mentor} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location",
                           group_mentor_path(conn, :show, group_id, mentor))
        |> render("show.json", mentor: mentor)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Edu.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"group_id" => group_id, "id" => id}) do
    mentor = Repo.one! from m in Mentor,
      where: m.group_id == ^group_id and m.id == ^id
    render(conn, "show.json", mentor: mentor)
  end

  def update(conn, %{"group_id" => group_id,
                     "id" => id,
                     "mentor" => mentor_params}) do
    mentor = Repo.one! from m in Mentor,
      where: m.group_id == ^group_id and m.id == ^id
    params = Map.merge(mentor_params, %Mentor{group_id: group_id})
    changeset = Mentor.changeset(mentor, params)

    case Repo.update(changeset) do
      {:ok, mentor} ->
        render(conn, "show.json", mentor: mentor)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Edu.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"group_id" => group_id, "id" => id}) do
    mentor = Repo.one! from m in Mentor,
      where: m.group_id == ^group_id and m.id == ^id

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(mentor)

    send_resp(conn, :no_content, "")
  end
end
