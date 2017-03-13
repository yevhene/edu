defmodule Edu.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :text, null: false
      add :password_hash, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create index(:users, [:email], unique: true)
  end
end
