defmodule PrayerRequests.Repo.Migrations.AddFieldToRequests do
  use Ecto.Migration

  def change do
    alter table(:requests) do
      add :count, :integer, default: 0
    end
  end
end
