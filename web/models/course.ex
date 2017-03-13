defmodule Edu.Course do
  use Edu.Web, :model

  schema "courses" do
    field :name, :string
    field :link, :string

    has_many :groups, Edu.Group

    timestamps(type: :utc_datetime)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :link])
    |> validate_required([:name])
  end
end
