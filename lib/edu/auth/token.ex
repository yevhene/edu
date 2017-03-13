defmodule Edu.Auth.Token do
  def generate(length \\ 64) do
    :crypto.strong_rand_bytes(length)
    |> Base.url_encode64
    |> binary_part(0, length)
  end
end
