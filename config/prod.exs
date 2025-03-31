import Config

# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix assets.deploy` task,
# which you should run after static files are built and
# before starting your production server.
config :dengutech, DengutechWeb.Endpoint, cache_static_manifest: "priv/static/cache_manifest.json"

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: Dengutech.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

config :dengutech, Dengutech.Repo,
  url: System.get_env("postgresql://dengutech_dev_user:3WyJhG1P6k91lNCRdz6TS0DoIf7ThyiB@dpg-cvkvndgdl3ps738dp7ug-a.oregon-postgres.render.com/dengutech_dev"),
  pool_size: 15,  # Ajusta según tus necesidades
  ssl: [verify: :verify_peer]
# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
