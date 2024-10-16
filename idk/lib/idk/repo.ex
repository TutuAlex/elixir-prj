defmodule Idk.Repo do
  use Ecto.Repo,
    otp_app: :idk,
    adapter: Ecto.Adapters.Postgres
end
