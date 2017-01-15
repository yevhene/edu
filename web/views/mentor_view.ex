defmodule Edu.MentorView do
  use Edu.Web, :view

  def render("index.json", %{mentors: mentors}) do
    %{data: render_many(mentors, Edu.MentorView, "mentor.json")}
  end

  def render("show.json", %{mentor: mentor}) do
    %{data: render_one(mentor, Edu.MentorView, "mentor.json")}
  end

  def render("mentor.json", %{mentor: mentor}) do
    %{
      id: mentor.id,
      group_id: mentor.group_id,
      user_id: mentor.user_id,
      inserted_at: mentor.inserted_at,
      updated_at: mentor.updated_at
    }
  end
end
