defmodule PrayerRequests.Repo.Migrations.GetAwayUsersTable do
  use Ecto.Migration

  def change do
    drop_if_exists table(:users)
  end
end
