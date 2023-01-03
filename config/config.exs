# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :tool_box,
  ecto_repos: [ToolBox.Repo]

# Configures the endpoint
config :tool_box, ToolBoxWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ToolBoxWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ToolBox.PubSub,
  live_view: [signing_salt: "x/SMA53+"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :tool_box, ToolBox.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Facilitate integration with S3 through ExAws.S3
config :waffle,
  # or Waffle.Storage.Local
  storage: Waffle.Storage.S3,
  # if using S3
  bucket: System.get_env("AWS_BUCKET_NAME")

# asset_host: "127.0.0.1"

# If using S3:
config :ex_aws,
  debug_requests: true,
  json_codec: Jason,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  # region: System.get_env("AWS_REGION") || "US East (Ohio) us-east-2",
  s3: [
    scheme: "https://",
    host: "amozone.s3.amazonaws.com",
    region: "us-east-1"
  ]

# git hooks configuration
if Mix.env() == :dev do
  config :git_hooks,
    auto_install: true,
    verbose: true,
    hooks: [
      pre_commit: [
        tasks: [
          {:mix_task, :format, ["--check-formatted"]},
          {:mix_task, :credo, ["--strict"]}
        ]
      ],
      pre_push: [
        tasks: [
          {:mix_task, :format, ["--check-formatted"]},
          {:mix_task, :credo, ["--strict"]},
          {:mix_task, :dialyzer},
          {:mix_task, :test, ["--color"]}
        ]
      ]
    ]
end

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
