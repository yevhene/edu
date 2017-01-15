defmodule Edu.CoordinatorController do
  use Edu.Web, :controller

  alias Edu.Coordinator

  def index(conn, _params) do
    coordinators = Repo.all(Coordinator)
    render(conn, "index.json", coordinators: coordinators)
  end

  def create(conn, %{"coordinator" => coordinator_params}) do
    changeset = Coordinator.changeset(%Coordinator{}, coordinator_params)

    case Repo.insert(changeset) do
      {:ok, coordinator} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", coordinator_path(conn, :show, coordinator))
        |> render("show.json", coordinator: coordinator)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Edu.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    coordinator = Repo.get!(Coordinator, id)
    render(conn, "show.json", coordinator: coordinator)
  end

  def update(conn, %{"id" => id, "coordinator" => coordinator_params}) do
    coordinator = Repo.get!(Coordinator, id)
    changeset = Coordinator.changeset(coordinator, coordinator_params)

    case Repo.update(changeset) do
      {:ok, coordinator} ->
        render(conn, "show.json", coordinator: coordinator)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Edu.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    coordinator = Repo.get!(Coordinator, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(coordinator)

    send_resp(conn, :no_content, "")
  end
end
