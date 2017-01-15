defmodule Edu.RegionView do
  use Edu.Web, :view

  def render("index.json", %{regions: regions}) do
    %{data: render_many(regions, Edu.RegionView, "region.json")}
  end

  def render("show.json", %{region: region}) do
    %{data: render_one(region, Edu.RegionView, "region.json")}
  end

  def render("region.json", %{region: region}) do
    %{
      id: region.id,
      name: region.name,
      kind: region.kind,
      parent_id: region.parent_id,
      inserted_at: region.inserted_at,
      updated_at: region.updated_at
    }
  end
end
