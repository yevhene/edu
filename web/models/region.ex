defmodule Edu.Region do
  use Edu.Web, :model

  schema "regions" do
    field :name, :string
    field :kind, :string

    belongs_to :parent, Edu.Region

    has_many :children, Edu.Region
    has_many :groups, Edu.Group

    timestamps(type: :utc_datetime)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :kind, :parent_id])
    |> validate_required([:name])
  end
end
