# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :edu,
  ecto_repos: [Edu.Repo]

# Configures the endpoint
config :edu, Edu.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "U8g+Xmu0hHxIAG3IPzmZdyp/qN2wU31K1qb9wRTien2mYVW/HgrTdOwSLE8dLvGl",
  render_errors: [view: Edu.ErrorView, accepts: ~w(json)],
  pubsub: [name: Edu.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
