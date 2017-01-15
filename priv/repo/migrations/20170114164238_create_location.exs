defmodule Edu.Repo.Migrations.CreateLocation do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :text, null: false
      add :address, :text
      add :phone, :text
      add :email, :text

      add :region_id, references(:regions), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:locations, [:region_id])
  end
end
