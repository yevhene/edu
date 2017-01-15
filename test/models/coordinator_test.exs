defmodule Edu.CoordinatorTest do
  use Edu.ModelCase

  alias Edu.Coordinator

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Coordinator.changeset(%Coordinator{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Coordinator.changeset(%Coordinator{}, @invalid_attrs)
    refute changeset.valid?
  end
end
