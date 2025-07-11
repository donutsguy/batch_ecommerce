# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :batch_ecommerce, BatchEcommerce.Accounts.Guardian,
  issuer: "batch_ecommerce",
  secret_key: "Pe8LqmslQgtxxjI8evNkIalimmWAOaYN71yfw9JltV6PmqqysJPCMoxNAlOKCGZ3"

config :batch_ecommerce,
  ecto_repos: [BatchEcommerce.Repo],
  generators: [timestamp_type: :utc_datetime]

config :phoenix_swagger, json_library: Jason

# Configures the endpoint
config :batch_ecommerce, BatchEcommerceWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: BatchEcommerceWeb.ErrorHTML, json: BatchEcommerceWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: BatchEcommerce.PubSub,
  live_view: [signing_salt: "3p3TM+Fu"]

config :batch_ecommerce, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      # phoenix routes will be converted to swagger paths
      router: BatchEcommerceWeb.Router,
      # (optional) endpoint config used to set host, port and https schemes.
      endpoint: BatchEcommerceWeb.Endpoint
    ]
  }

config :phoenix_swagger, PhoenixSwagger.Plug.SwaggerUI, otp_app: :batch_ecommerce

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :batch_ecommerce, BatchEcommerce.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  batch_ecommerce: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  batch_ecommerce: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :batch_ecommerce, BatchEcommerceFinch,
  pools: %{
    default: [size: 25]
  }

config :ex_aws,
  region: "us-east-1"

config :ex_aws, :s3,
  region: "us-east-1",
  host: "localhost",
  scheme: "http://",
  port: 9000

config :flop, repo: BatchEcommerce.Repo
