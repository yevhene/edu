defmodule Edu.ErrorViewTest do
  use Edu.ConnCase, async: true

  import Phoenix.View, only: [render_to_string: 3]

  test "renders 401.json" do
    content = render_to_string(Edu.ErrorView, "401.json", [])

    assert String.contains?(content, "Unauthorized")
  end

  test "renders 404.json" do
    content = render_to_string(Edu.ErrorView, "404.json", [])

    assert String.contains?(content, "Page not found")
  end

  test "render 500.json" do
    content = render_to_string(Edu.ErrorView, "500.json", [])

    assert String.contains?(content, "Internal server error")
  end

  test "render any other" do
    content = render_to_string(Edu.ErrorView, "505.json", [])

    assert String.contains?(content, "Internal server error")
  end
end
