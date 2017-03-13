defmodule Edu.User do
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  use Edu.Web, :model

  schema "users" do
    field :email, :string

    field :password_hash, :string
    field :password, :string, virtual: true

    has_many :coordinators, Edu.Coordinator
    has_many :mentors, Edu.Mentor
    has_many :students, Edu.Student

    timestamps(type: :utc_datetime)
  end

  def create_registration_changeset(struct, params \\ %{}) do
    struct
    |> update_registration_changeset(params)
    |> validate_required([:password])
  end

  def update_registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
