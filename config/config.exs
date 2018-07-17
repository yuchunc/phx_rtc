# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phx_rtc,
  ecto_repos: [PhxRtc.Repo]

# Configures the endpoint
config :phx_rtc, PhxRtcWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tljf3nNyw8oBwxXWdGLeEt7odG4zcsWWXaGalv1NmHB3KrGSpoK3bYK+t261q44T",
  render_errors: [view: PhxRtcWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhxRtc.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
