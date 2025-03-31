import Config

# Configuración de runtime para todas las configuraciones
if System.get_env("PHX_SERVER") do
  config :dengutech, DengutechWeb.Endpoint, server: true
end

# Configuración específica para producción
if config_env() == :prod do
  # Define la URL de la base de datos (DATABASE_URL)
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: postgresql://USER:PASS@HOST/DATABASE
      """

  maybe_ipv6 = if System.get_env("ECTO_IPV6") in ~w(true 1), do: [:inet6], else: []

  config :dengutech, Dengutech.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    socket_options: maybe_ipv6,
    ssl: [verify: :verify_peer]

  # Define la clave secreta (SECRET_KEY_BASE) para seguridad
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  # Define el host y el puerto para el servidor Phoenix
  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :dengutech, :dns_cluster_query, System.get_env("DNS_CLUSTER_QUERY")

  config :dengutech, DengutechWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0}, # IPv6 habilitado
      port: port
    ],
    secret_key_base: secret_key_base

  # Configuración SSL si es necesario
  # Puedes habilitar esta sección si tienes archivos de certificado SSL disponibles
  # config :dengutech, DengutechWeb.Endpoint,
  #   https: [
  #     port: 443,
  #     cipher_suite: :strong,
  #     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
  #     certfile: System.get_env("SOME_APP_SSL_CERT_PATH")
  #   ]
end
