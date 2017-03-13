defmodule Edu.User do
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

  def changeset_create(struct, params \\ %{}) do
    changeset(struct, params)
    |> validate_required([:password])
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> hash_password(:password, :password_hash)
  end

  defp hash_password(changeset, source, dest) do
    if password = get_change(changeset, source) do
      changeset
      |> put_change(dest, Comeonin.Bcrypt.hashpwsalt(password))
    else
      changeset
    end
  end
end
