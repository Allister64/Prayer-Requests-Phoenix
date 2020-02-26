defmodule PrayerRequests.LdapManager.Ldap do
  use Ecto.Schema
  import Ecto.Changeset


  schema "ldaps" do
    field :email, :string
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    
    timestamps()
  end

  @doc false
  def changeset(ldap, attrs) do
    ldap
    |> cast(attrs, [:username, :name, :email])
    |> validate_required([:username, :name, :email])
  end

  def login_changeset do
    %__MODULE__{} |> cast(%{}, ~w(username password), ~w())
  end
end
