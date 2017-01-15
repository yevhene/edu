defmodule Edu.Mentor do
  use Edu.Web, :model

  schema "mentors" do
    belongs_to :group, Edu.Group
    belongs_to :user, Edu.User

    timestamps(type: :utc_datetime)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:group_id, :user_id])
    |> validate_required([:group_id, :user_id])
  end
end
