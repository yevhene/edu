defmodule Edu.Repo.Migrations.CreateStudent do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :group_id, references(:groups), null: false
      add :user_id, references(:users), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:students, [:group_id])
    create index(:students, [:user_id])
  end
end
