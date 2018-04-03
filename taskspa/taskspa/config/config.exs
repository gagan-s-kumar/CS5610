# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :taskspa,
  ecto_repos: [Taskspa.Repo]

# Configures the endpoint
config :taskspa, TaskspaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QfektKpPmz5Ti69VO258XEgpb9qHtvbbSMR4/zX37Qi9alV/dZ/FwwLYq1Pmxm00",
  render_errors: [view: TaskspaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Taskspa.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
