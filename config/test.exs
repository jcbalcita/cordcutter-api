use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cordcutter_api, CordcutterApi.Endpoint,
  http: [port: 4001],
  server: false,
  api_key: System.get_env("API_KEY"),
  base_url: System.get_env("BASE_URL")

config :cordcutter_api,
  url: CordcutterApi.TestUrl,
  requester: CordcutterApi.TestRequester

# Print only warnings and errors during test
config :logger, level: :warn
