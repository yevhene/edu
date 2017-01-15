defmodule Edu.Location do
  use Edu.Web, :model

  schema "locations" do
    field :name, :string
    field :address, :string
    field :phone, :string
    field :email, :string

    belongs_to :region, Edu.Region

    has_many :groups, Edu.Group

    timestamps(type: :utc_datetime)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :address, :phone, :email, :region_id])
    |> validate_required([:name, :address, :phone, :email, :region_id])
  end
end
