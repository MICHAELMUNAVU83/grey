defmodule Grey.Repo do
  use Ecto.Repo,
    otp_app: :grey,
    adapter: Ecto.Adapters.MyXQL
end
