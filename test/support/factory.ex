defmodule Edu.Factory do
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  use ExMachina.Ecto, repo: Edu.Repo

  def user_factory do
    %Edu.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password_hash: hashpwsalt("password")
    }
  end
end
