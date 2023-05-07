defmodule PhxPackingList.Repo do
  use Ecto.Repo,
    otp_app: :phx_packing_list,
    adapter: Ecto.Adapters.Postgres
end
