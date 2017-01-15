defmodule Edu.Repo.Migrations.CreateMentor do
  use Ecto.Migration

  def change do
    create table(:mentors) do
      add :group_id, references(:groups), null: false
      add :user_id, references(:users), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:mentors, [:group_id])
    create index(:mentors, [:user_id])
  end
end
