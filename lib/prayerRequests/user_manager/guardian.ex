defmodule PrayerRequests.UserManager.Guardian do
  use Guardian, otp_app: :prayerRequests

  alias PrayerRequests.UserManager
  alias PrayerRequests.LdapManager

  # def subject_for_token(user, _claims) do
  #   {:ok, to_string(user.id)}
  # end

  # def resource_from_claims(%{"sub" => id}) do
  #   case UserManager.get_user!(id) do
  #     nil -> {:error, :resource_not_found}
  #     user -> {:ok, user}
  #   end
  # end

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case LdapManager.get_ldap!(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
end