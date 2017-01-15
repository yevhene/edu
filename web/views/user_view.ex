defmodule Edu.UserView do
  use Edu.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Edu.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Edu.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end
end
