defmodule Edu.Repo.Migrations.CreateRegion do
  use Ecto.Migration

  def change do
    create table(:regions) do
      add :name, :text, null: false
      add :kind, :text

      add :parent_id, references(:regions)

      timestamps(type: :utc_datetime)
    end

    create index(:regions, [:parent_id])
  end
end
