defmodule PrayerRequests.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :name, :string
      add :place, :string
      add :original_request, :text
      add :sanitized_request, :text

      timestamps()
    end

  end
end
