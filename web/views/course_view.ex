defmodule Edu.CourseView do
  use Edu.Web, :view

  def render("index.json", %{courses: courses}) do
    %{data: render_many(courses, Edu.CourseView, "course.json")}
  end

  def render("show.json", %{course: course}) do
    %{data: render_one(course, Edu.CourseView, "course.json")}
  end

  def render("course.json", %{course: course}) do
    %{
      id: course.id,
      name: course.name,
      link: course.link,
      inserted_at: course.inserted_at,
      updated_at: course.updated_at
    }
  end
end
