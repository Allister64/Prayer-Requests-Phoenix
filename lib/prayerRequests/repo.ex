defmodule PrayerRequests.Repo do
  use Ecto.Repo,
    otp_app: :prayerRequests,
    adapter: Ecto.Adapters.MySQL
  use Scrivener, page_size: 20
end
