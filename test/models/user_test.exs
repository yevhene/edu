defmodule Edu.UserTest do
  use Edu.ModelCase

  alias Edu.User

  describe "#create_registration_changeset" do
    @valid_attrs %{email: "user@example.com", password: "password"}

    test "changeset with valid attributes" do
      changeset = User.create_registration_changeset(%User{}, @valid_attrs)

      assert changeset.valid?
    end

    test "changeset with no password" do
      changeset = User.create_registration_changeset(
        %User{}, %{@valid_attrs | password: nil}
      )

      refute changeset.valid?
    end
  end

  describe "#update_registration_changeset" do
    @valid_attrs %{email: "user@example.com", password: "password"}

    test "changeset with valid attributes" do
      changeset = User.update_registration_changeset(%User{}, @valid_attrs)

      assert changeset.valid?
    end

    test "changeset with no email" do
      changeset = User.update_registration_changeset(
        %User{}, %{@valid_attrs | email: nil}
      )

      refute changeset.valid?
    end

    test "changeset with wrong email format" do
      changeset = User.update_registration_changeset(
        %User{}, %{@valid_attrs | email: "user"}
      )

      refute changeset.valid?
    end

    test "changeset with no password" do
      changeset = User.update_registration_changeset(
        %User{}, %{@valid_attrs | password: nil}
      )

      assert changeset.valid?
    end

    test "changeset with short password" do
      changeset = User.update_registration_changeset(
        %User{}, %{@valid_attrs | password: "pass"}
      )

      refute changeset.valid?
    end
  end
end
