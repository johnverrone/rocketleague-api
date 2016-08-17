use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rocketleague_phoenix, RocketleaguePhoenix.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :rocketleague_phoenix, RocketleaguePhoenix.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "rocketleague_phoenix_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
