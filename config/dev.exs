import Config
IO.puts("PGHOST: #{System.get_env("PGHOST") || "NOT FOUND"}")
IO.puts("PGUSER: #{System.get_env("PGUSER") || "NOT FOUND"}")
IO.puts("PGPORT: #{System.get_env("PGPORT") || "NOT FOUND"}")

# Configure your database
config :batch_ecommerce, BatchEcommerce.Repo,
  username: System.get_env("PGUSER") || "postgres",
  password: System.get_env("PGPASSWORD") || "postgres",
  database: System.get_env("PGDATABASE") || "batch_ecommerce_dev",
  hostname: System.get_env("PGHOST") || "localhost",
  port: String.to_integer(System.get_env("PGPORT") || "5432"),
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we can use it
# to bundle .js and .css sources.
config :batch_ecommerce, BatchEcommerceWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {0, 0, 0, 0}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "6KaOnu93iIW9651gKGbiE7x7LohtY6+eJ22ZgpYckSuuUVRAl6KElFOOxY+l2gP4",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:batch_ecommerce, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:batch_ecommerce, ~w(--watch)]}
  ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Enable dev routes for dashboard and mailbox
config :batch_ecommerce, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

config :ex_aws,
  access_key_id: "minioaccesskey",
  secret_access_key: "miniosecretkey",
  json_codec: Jason

config :ex_aws, :s3,
  scheme: "http://",
  host: "localhost",
  port: 9000,
  bucket: "batch-bucket",
  force_path_style: true

# TODO: see a better way to get env config in the future
# config :batch_ecommerce, origin: ["http://localhost:4200"]
