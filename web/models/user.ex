defmodule Edu.User do
  use Edu.Web, :model

  schema "users" do
    field :email, :string

    has_many :coordinators, Edu.Coordinator
    has_many :mentors, Edu.Mentor
    has_many :students, Edu.Student

    timestamps(type: :utc_datetime)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email])
    |> validate_required([:email])
  end
end
