defmodule PrayerRequests.LdapManager do
  @moduledoc """
  The LdapManager context.
  """

  import Ecto.Query, warn: false
  alias PrayerRequests.Repo

  alias PrayerRequests.LdapManager.Ldap

  @doc """
  Returns the list of ldaps.

  ## Examples

      iex> list_ldaps()
      [%Ldap{}, ...]

  """
  def list_ldaps do
    Repo.all(Ldap)
  end

  @doc """
  Gets a single ldap.

  Raises `Ecto.NoResultsError` if the Ldap does not exist.

  ## Examples

      iex> get_ldap!(123)
      %Ldap{}

      iex> get_ldap!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ldap!(id), do: Repo.get!(Ldap, id)

  @doc """
  Creates a ldap.

  ## Examples

      iex> create_ldap(%{field: value})
      {:ok, %Ldap{}}

      iex> create_ldap(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ldap(attrs \\ %{}) do
    %Ldap{}
    |> Ldap.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ldap.

  ## Examples

      iex> update_ldap(ldap, %{field: new_value})
      {:ok, %Ldap{}}

      iex> update_ldap(ldap, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ldap(%Ldap{} = ldap, attrs) do
    ldap
    |> Ldap.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ldap.

  ## Examples

      iex> delete_ldap(ldap)
      {:ok, %Ldap{}}

      iex> delete_ldap(ldap)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ldap(%Ldap{} = ldap) do
    Repo.delete(ldap)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ldap changes.

  ## Examples

      iex> change_ldap(ldap)
      %Ecto.Changeset{source: %Ldap{}}

  """
  def change_ldap(%Ldap{} = ldap) do
    Ldap.changeset(ldap, %{})
  end
end
