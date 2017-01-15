defmodule Edu.StudentView do
  use Edu.Web, :view

  def render("index.json", %{students: students}) do
    %{data: render_many(students, Edu.StudentView, "student.json")}
  end

  def render("show.json", %{student: student}) do
    %{data: render_one(student, Edu.StudentView, "student.json")}
  end

  def render("student.json", %{student: student}) do
    %{
      id: student.id,
      group_id: student.group_id,
      user_id: student.user_id,
      inserted_at: student.inserted_at,
      updated_at: student.updated_at
    }
  end
end
