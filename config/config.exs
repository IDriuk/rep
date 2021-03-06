# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :rep,
  ecto_repos: [Rep.Repo]

# Configures the endpoint
config :rep, RepWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+J02qYUvMZnfqZskyO8cnV24MASNJpWb9VY9CrstgnucZBvunwWpsFi4fiJaX1oe",
  render_errors: [view: RepWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Rep.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :rep, RepWeb.Gettext, default_locale: "ru_RU"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
