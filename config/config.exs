# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cordcutter_api,
  ecto_repos: [CordcutterApi.Repo]

# Configures the endpoint
config :cordcutter_api, CordcutterApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MDbrNCy+Wi8v/0p3jhuUvPBiGqrQHC/UoD4vvZ2IoveCjLpb5qT/lE3q7yUETnGX",
  render_errors: [view: CordcutterApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CordcutterApi.PubSub,
           adapter: Phoenix.PubSub.PG2],
  api_key: System.get_env("API_KEY"),
  base_url: System.get_env("BASE_URL"),
  movie_query: System.get_env("MOVIE_QUERY")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
