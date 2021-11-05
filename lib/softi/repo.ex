defmodule Softi.Repo do
  use Ecto.Repo,
    otp_app: :softi,
    adapter: Ecto.Adapters.Postgres
end
