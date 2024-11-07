# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :idk,
  ecto_repos: [Idk.Repo]

# Configures the endpoint
config :idk, IdkWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "onjOkKUj6lB1SkKv/S24f3oGKADG4ZW1dxZERk5SE2pZUJWqrn6YlITnnqZPArs8",
  render_errors: [view: IdkWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Idk.PubSub,
  live_view: [signing_salt: "CyLztYh/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs" #i replaced Mix.env() with config_env()
