use Mix.Config

config :logger, :console, metadata: [:request_id]

import_config "#{Mix.env()}.exs"
import_config "#{Mix.env()}.secret.exs"
