defmodule Household.Repo do
  use Ecto.Repo,
    otp_app: :household,
    adapter: Ecto.Adapters.Postgres
    use Scrivener, page_size: 20
end
