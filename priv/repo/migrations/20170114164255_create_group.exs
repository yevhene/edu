defmodule Edu.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :text, null: false
      add :started_at, :utc_datetime
      add :finished_at, :utc_datetime

      add :course_id, references(:courses)
      add :location_id, references(:locations), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:groups, [:course_id])
    create index(:groups, [:location_id])
  end
end
