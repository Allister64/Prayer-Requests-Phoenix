defmodule PrayerRequestsWeb.SessionController do
  use PrayerRequestsWeb, :controller

  alias PrayerRequests.{UserManager, UserManager.User, UserManager.Guardian}
  alias PrayerRequests.{LdapManager, LdapManager.Ldap, Repo, LdapManager.LdapStuff}


  def new(conn, _params) do
    changeset = LdapManager.change_ldap(%Ldap{})
    maybe_user = Guardian.Plug.current_resource(conn)
    if maybe_user do
      redirect(conn, to: "/secret")
    else
      render(conn, "login.html", changeset: changeset)
    end
  end

  def create(conn, %{"ldap" => %{"username" => username, "password" => password}}) do
    case LdapStuff.new_auth(username, password) do
      :ok -> handle_sign_in(conn, username, password)
      _  -> handle_error(conn)
    end
  end

  defp handle_sign_in(conn, username, password) do
    {:ok, user} = new_insert_or_update_user(username, password)
    conn
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/secret")
  end
    
  defp new_insert_or_update_user(username, password) do
    {:ok, ldap_entry} = LdapStuff.get_by_uid(username, password)
    user_attributes = LdapStuff.to_map(ldap_entry)
    user = Repo.get_by(Ldap, username: username)
    changeset =
      case user do
        nil -> Ldap.changeset(%Ldap{}, user_attributes)
        _ -> Ldap.changeset(user, user_attributes)
      end
    Repo.insert_or_update changeset
  end

  defp handle_error(conn) do
    conn = put_layout conn, false
    conn
    |> put_flash(:error, "Wrong username or password")
    |> redirect(to: "/login")
  end

  def logout(conn, _params) do
    conn = put_layout conn, false
    Guardian.Plug.sign_out(conn)
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: "/login")
  end
end
