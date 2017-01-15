defmodule Edu.SessionView do
  use Edu.Web, :view

  def render("index.json", %{sessions: sessions}) do
    %{data: render_many(sessions, Edu.SessionView, "session.json")}
  end

  def render("show.json", %{session: session}) do
    %{data: render_one(session, Edu.SessionView, "session.json")}
  end

  def render("session.json", %{session: session}) do
    %{
      id: session.id,
      token: session.token,
      user_id: session.user_id,
      inserted_at: session.inserted_at,
      updated_at: session.updated_at
    }
  end
end
