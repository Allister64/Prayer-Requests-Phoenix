defmodule PrayerRequests.Repo.Migrations.AddVirtualPassLdap do
  use Ecto.Migration

  def change do
    alter table(:ldaps) do
      add :password, :string, virtual: true
    end
  end
end
