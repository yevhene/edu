defmodule Edu.Repo.Migrations.CreateSession do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :token, :text, null: false
      add :expired_at, :utc_datetime

      add :user_id, references(:users), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:sessions, [:user_id])
  end
end
