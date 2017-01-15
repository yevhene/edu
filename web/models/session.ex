defmodule Edu.Session do
  use Edu.Web, :model

  schema "sessions" do
    field :token, :string
    field :expired_at, :utc_datetime

    belongs_to :user, Edu.User

    timestamps(type: :utc_datetime)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:token, :user_id])
    |> validate_required([:token, :user_id])
  end
end
