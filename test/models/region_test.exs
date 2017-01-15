defmodule Edu.RegionTest do
  use Edu.ModelCase

  alias Edu.Region

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Region.changeset(%Region{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Region.changeset(%Region{}, @invalid_attrs)
    refute changeset.valid?
  end
end
