defmodule Edu.Coordinator do
  use Edu.Web, :model

  schema "coordinators" do
    belongs_to :region, Edu.Region
    belongs_to :user, Edu.Region

    timestamps(type: :utc_datetime)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:region_id, :user_id])
    |> validate_required([:region_id, :user_id])
  end
end
