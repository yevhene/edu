defmodule Edu.Repo.Migrations.CreateCourse do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :name, :text, null: false
      add :link, :text

      timestamps(type: :utc_datetime)
    end
  end
end
