defmodule PharmaDash.Repo do
  use Ecto.Repo,
    otp_app: :pharma_dash,
    adapter: Ecto.Adapters.Postgres
end
