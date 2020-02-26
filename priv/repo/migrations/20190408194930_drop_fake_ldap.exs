defmodule PrayerRequests.Repo.Migrations.DropFakeLdap do
  use Ecto.Migration

  def change do
    drop_if_exists table(:ldaps)
  end
end
