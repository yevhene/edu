defmodule Edu.LocationView do
  use Edu.Web, :view

  def render("index.json", %{locations: locations}) do
    %{data: render_many(locations, Edu.LocationView, "location.json")}
  end

  def render("show.json", %{location: location}) do
    %{data: render_one(location, Edu.LocationView, "location.json")}
  end

  def render("location.json", %{location: location}) do
    %{
      id: location.id,
      name: location.name,
      address: location.address,
      phone: location.phone,
      email: location.email,
      region_id: location.region_id,
      inserted_at: location.inserted_at,
      updated_at: location.updated_at
    }
  end
end
