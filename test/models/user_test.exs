defmodule Edu.UserTest do
  use Edu.ModelCase

  alias Edu.User

  @valid_attrs %{email: "user@example.com", password: "password"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with no email" do
    changeset = User.changeset(%User{}, %{@valid_attrs | email: nil})
    refute changeset.valid?
  end

  test "changeset with wrong email format" do
    changeset = User.changeset(%User{}, %{@valid_attrs | email: "user"})
    refute changeset.valid?
  end

  test "changeset with no password" do
    changeset = User.changeset(%User{}, %{@valid_attrs | password: nil})
    refute changeset.valid?
  end

  test "changeset with short password" do
    changeset = User.changeset(%User{}, %{@valid_attrs | password: "pass"})
    refute changeset.valid?
  end
end
