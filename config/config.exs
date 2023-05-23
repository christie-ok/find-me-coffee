import Config

config :tesla, adapter: Tesla.Adapter.Hackney

import_config "#{config_env()}.exs"
