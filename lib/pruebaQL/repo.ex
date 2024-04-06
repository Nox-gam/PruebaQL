defmodule PruebaQL.Repo do
  use Ecto.Repo,
    otp_app: :pruebaQL,
    adapter: Ecto.Adapters.Postgres
end
