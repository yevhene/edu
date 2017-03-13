defmodule Edu.Session do
  import Comeonin.Bcrypt, only: [checkpw: 2]

  use Edu.Web, :model

  alias Edu.Repo

  schema "sessions" do
    field :token, :string
    field :expired_at, :utc_datetime

    field :email, :string, virtual: true
    field :password, :string, virtual: true

    belongs_to :user, Edu.User

    timestamps(type: :utc_datetime)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> authenticate
    |> put_change(:token, Edu.Auth.Token.generate())
  end

  defp authenticate(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{
        email: email, password: password
      }} ->
        if user = Repo.get_by(Edu.User, %{email: email}) do
          if checkpw(password, user.password_hash) do
            put_change(changeset, :user_id, user.id)
          else
            add_error(changeset, :credentials, "wrong")
          end
        else
          add_error(changeset, :credentials, "wrong")
        end
      _ ->
        changeset
    end
  end
end
