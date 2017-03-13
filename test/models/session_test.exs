defmodule Edu.SessionTest do
  use Edu.ModelCase

  alias Edu.Session

  describe "#changeset" do
    setup do
      {:ok, user: insert(:user)}
    end

    test "changeset with valid attributes", %{user: user} do
      changeset = Session.changeset(%Session{}, %{
        email: user.email, password: user.password
      })

      assert changeset.valid?, changeset.errors
      assert changeset.changes[:token] != nil
      assert changeset.changes[:user_id] == user.id
    end

    test "changeset with no email", %{user: user} do
      changeset = Session.changeset(%Session{}, %{
        email: nil, password: user.password
      })

      refute changeset.valid?
    end

    test "changeset with unexistent email", %{user: user} do
      changeset = Session.changeset(%Session{}, %{
        email: "wrong", password: user.password
      })

      refute changeset.valid?
    end

    test "changeset with no password", %{user: user} do
      changeset = Session.changeset(%Session{}, %{
        email: user.email, password: nil
      })

      refute changeset.valid?
    end

    test "changeset with wront password", %{user: user} do
      changeset = Session.changeset(%Session{}, %{
        email: user.email, password: "wrong"
      })

      refute changeset.valid?
    end
  end
end
