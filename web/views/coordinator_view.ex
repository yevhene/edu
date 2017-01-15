defmodule Edu.CoordinatorView do
  use Edu.Web, :view

  def render("index.json", %{coordinators: coordinators}) do
    %{data: render_many(coordinators, Edu.CoordinatorView, "coordinator.json")}
  end

  def render("show.json", %{coordinator: coordinator}) do
    %{data: render_one(coordinator, Edu.CoordinatorView, "coordinator.json")}
  end

  def render("coordinator.json", %{coordinator: coordinator}) do
    %{
      id: coordinator.id,
      region_id: coordinator.region_id,
      user_id: coordinator.user_id,
      inserted_at: coordinator.inserted_at,
      updated_at: coordinator.updated_at
    }
  end
end
