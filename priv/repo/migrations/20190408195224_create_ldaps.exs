defmodule PrayerRequests.Repo.Migrations.CreateLdaps do
  use Ecto.Migration

  def change do
    create table(:ldaps) do
      add :username, :string
      add :name, :string
      add :email, :string

      timestamps()
    end

  end
end
