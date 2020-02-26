defmodule PrayerRequests.LdapManagerTest do
  use PrayerRequests.DataCase

  alias PrayerRequests.LdapManager

  describe "ldaps" do
    alias PrayerRequests.LdapManager.Ldap

    @valid_attrs %{email: "some email", name: "some name", username: "some username"}
    @update_attrs %{email: "some updated email", name: "some updated name", username: "some updated username"}
    @invalid_attrs %{email: nil, name: nil, username: nil}

    def ldap_fixture(attrs \\ %{}) do
      {:ok, ldap} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LdapManager.create_ldap()

      ldap
    end

    test "list_ldaps/0 returns all ldaps" do
      ldap = ldap_fixture()
      assert LdapManager.list_ldaps() == [ldap]
    end

    test "get_ldap!/1 returns the ldap with given id" do
      ldap = ldap_fixture()
      assert LdapManager.get_ldap!(ldap.id) == ldap
    end

    test "create_ldap/1 with valid data creates a ldap" do
      assert {:ok, %Ldap{} = ldap} = LdapManager.create_ldap(@valid_attrs)
      assert ldap.email == "some email"
      assert ldap.name == "some name"
      assert ldap.username == "some username"
    end

    test "create_ldap/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LdapManager.create_ldap(@invalid_attrs)
    end

    test "update_ldap/2 with valid data updates the ldap" do
      ldap = ldap_fixture()
      assert {:ok, %Ldap{} = ldap} = LdapManager.update_ldap(ldap, @update_attrs)
      assert ldap.email == "some updated email"
      assert ldap.name == "some updated name"
      assert ldap.username == "some updated username"
    end

    test "update_ldap/2 with invalid data returns error changeset" do
      ldap = ldap_fixture()
      assert {:error, %Ecto.Changeset{}} = LdapManager.update_ldap(ldap, @invalid_attrs)
      assert ldap == LdapManager.get_ldap!(ldap.id)
    end

    test "delete_ldap/1 deletes the ldap" do
      ldap = ldap_fixture()
      assert {:ok, %Ldap{}} = LdapManager.delete_ldap(ldap)
      assert_raise Ecto.NoResultsError, fn -> LdapManager.get_ldap!(ldap.id) end
    end

    test "change_ldap/1 returns a ldap changeset" do
      ldap = ldap_fixture()
      assert %Ecto.Changeset{} = LdapManager.change_ldap(ldap)
    end
  end
end
