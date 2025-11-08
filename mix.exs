defmodule BatchEcommerce.MixProject do
  use Mix.Project

  def project do
    [
      app: :batch_ecommerce,
      version: "0.1.0",
      elixir: "~> 1.19.2",
      compilers: Mix.compilers ++ [:phoenix_swagger],
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type mix help compile.app for more information.
  def application do
    [
      mod: {BatchEcommerce.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/factories", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type mix help deps for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.8.1"},
      {:phoenix_ecto, "~> 4.7.0"},
      {:ecto_sql, "~> 3.13.2"},
      {:scrivener_ecto, "~> 3.1.0"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 4.3.0"},
      {:phoenix_live_reload, "~> 1.6.1", only: :dev},
      {:phoenix_live_view, "~> 1.1.17"},
      {:floki, ">= 0.38.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.7"},
      {:esbuild, "~> 0.10.0", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.4.1", runtime: Mix.env() == :dev},
      {:phoenix_html_helpers, "~> 1.0.1"},
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.1.1",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1},
      {:swoosh, "~> 1.19.8"},
      {:nimble_csv, "~> 1.3.0"},
      {:finch, "~> 0.20.0"},
      {:telemetry_metrics, "~> 1.1.0"},
      {:telemetry_poller, "~> 1.3.0"},
      {:gettext, "~> 1.0.2"},
      {:jason, "~> 1.4.4"},
      {:dns_cluster, "~> 0.2.0"},
      {:bandit, "~> 1.8.0"},
      {:bcrypt_elixir, "~> 3.3.2"},
      {:guardian, "~> 2.4.0"},
      {:credo, "~> 1.7.13", only: [:dev, :test], runtime: false},
      {:ecto_commons, "~> 0.3.6"},
      {:mox, "~> 1.2", only: :test},
      {:hammox, "~> 0.7.1", only: :test},
      {:ex_aws, "~> 2.6.0"},
      {:ex_aws_s3, "~> 2.5.8"},
      {:hackney, "~> 1.25.0"},
      {:sweet_xml, "~> 0.7.5"},
      {:mock, "~> 0.3.9"},
      {:uuid, "~> 1.1.8"},
      {:cors_plug, "~> 3.0.3"},
      {:plug_crypto, "~> 2.1.1"},
      {:flop, "~> 0.26.3"},
      {:ex_machina, "~> 2.8.0", only: :test},
      {:brcpfcnpj, "~> 2.0.2"},
      {:phoenix_swagger, "~> 0.8.5"},
      {:ex_json_schema, "~> 0.11.1"}
      ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for Mix for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind batch_ecommerce", "esbuild batch_ecommerce"],
      "assets.deploy": [
        "tailwind batch_ecommerce --minify",
        "esbuild batch_ecommerce --minify",
        "phx.digest"
      ]
    ]
  end
end
