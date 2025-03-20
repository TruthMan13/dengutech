defmodule Dengutech.Repo do
  use Ecto.Repo,
    otp_app: :dengutech,
    adapter: Ecto.Adapters.Postgres
end
