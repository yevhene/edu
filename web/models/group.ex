defmodule Edu.Group do
  use Edu.Web, :model

  schema "groups" do
    field :name, :string
    field :started_at, :utc_datetime
    field :finished_at, :utc_datetime

    belongs_to :course, Edu.Region
    belongs_to :location, Edu.Region

    has_many :mentors, Edu.Mentor
    has_many :students, Edu.Student

    timestamps(type: :utc_datetime)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :course_id, :location_id])
    |> validate_required([:name, :location_id])
  end
end
