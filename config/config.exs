# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :rocketleague_phoenix,
  ecto_repos: [RocketleaguePhoenix.Repo]

# Configures the endpoint
config :rocketleague_phoenix, RocketleaguePhoenix.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rH6/FFSKtWz8ne5n2KmsNy0sCr6RlCmO+xNP6k/ek8rnzyBH7mVefy2IYA9vm2iQ",
  render_errors: [view: RocketleaguePhoenix.ErrorView, accepts: ~w(json)],
  pubsub: [name: RocketleaguePhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :phoenix, :format_encoders,
  "json-api": Poison

config :plug, :mimes, %{
  "application/vnd.api+json" => ["json-api"]
}

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures authentication with guardian
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "MyApp",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: System.get_env("GUARDIAN_SECRET") || "rFC9BMrzRDRpgT4u65nOsEXgeeGMv5KA9j4YsY5Wb6KbTeTd00FRst3vn56Wluk+",
  serializer: RocketleaguePhoenix.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
