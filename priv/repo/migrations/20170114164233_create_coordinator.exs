defmodule Edu.Repo.Migrations.CreateCoordinator do
  use Ecto.Migration

  def change do
    create table(:coordinators) do
      add :region_id, references(:regions), null: false
      add :user_id, references(:users), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:coordinators, [:region_id])
    create index(:coordinators, [:user_id])
  end
end
