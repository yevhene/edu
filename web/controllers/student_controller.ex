defmodule Edu.StudentController do
  use Edu.Web, :controller

  alias Edu.Student

  def index(conn, %{"group_id" => group_id}) do
    students = Repo.all from m in Student,
      where: m.group_id == ^group_id
    render(conn, "index.json", students: students)
  end

  def create(conn, %{"group_id" => group_id, "student" => student_params}) do
    params = Map.merge(student_params, %Student{group_id: group_id})
    changeset = Student.changeset(%Student{}, params)

    case Repo.insert(changeset) do
      {:ok, student} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location",
                           group_student_path(conn, :show, group_id, student))
        |> render("show.json", student: student)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Edu.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"group_id" => group_id, "id" => id}) do
    student = Repo.one! from m in Student,
      where: m.group_id == ^group_id and m.id == ^id
    render(conn, "show.json", student: student)
  end

  def update(conn, %{"group_id" => group_id,
                     "id" => id,
                     "student" => student_params}) do
    student = Repo.one! from m in Student,
      where: m.group_id == ^group_id and m.id == ^id
    params = Map.merge(student_params, %Student{group_id: group_id})
    changeset = Student.changeset(student, params)

    case Repo.update(changeset) do
      {:ok, student} ->
        render(conn, "show.json", student: student)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Edu.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"group_id" => group_id, "id" => id}) do
    student = Repo.one! from m in Student,
      where: m.group_id == ^group_id and m.id == ^id

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(student)

    send_resp(conn, :no_content, "")
  end
end
