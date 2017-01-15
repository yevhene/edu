defmodule Edu.GroupView do
  use Edu.Web, :view

  def render("index.json", %{groups: groups}) do
    %{data: render_many(groups, Edu.GroupView, "group.json")}
  end

  def render("show.json", %{group: group}) do
    %{data: render_one(group, Edu.GroupView, "group.json")}
  end

  def render("group.json", %{group: group}) do
    %{
      id: group.id,
      name: group.name,
      started_at: group.started_at,
      finished_at: group.finished_at,
      course_id: group.course_id,
      location_id: group.location_id,
      inserted_at: group.inserted_at,
      updated_at: group.updated_at
    }
  end
end
