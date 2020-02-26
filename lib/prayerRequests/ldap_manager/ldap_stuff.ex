defmodule PrayerRequests.LdapManager.LdapStuff do 

  alias PrayerRequests.LdapManager.Ldap


  # I'm sending this to you so I don't loose it, it seems to work, but obviously not like we want it to:\
  #  ldapsearch -x -LLL -h 172.16.170.10 -p 389 -w $pass -D "CN=John Doe,OU=GAPS,DC=ad,DC=iiw,DC=org" 
  # -b "dc=ad,dc=iiw,dc=org" -s sub 'objectClass=*'

  def authenticate(uid, password) do
      {:ok, ldap_conn} = Exldap.open("ad.iiw.org", 389, false)
    bind = "uid=#{uid},dc=ad,dc=iiw,dc=org"
    case Exldap.verify_credentials(ldap_conn, bind, password) do
      :ok -> :ok
      _ -> {:error, "Invalid username / password"}
    end
  end



  def get_by_uid(uid, password) do
    {:ok, ldap_conn} = Exldap.connect("172.16.170.10", 389, false, "#{uid}@ad.iiw.org", password, 1000)  
    {:ok, search_results} = Exldap.search_field(ldap_conn, "OU=GAPS,DC=ad,DC=iiw,DC=org", "sAMAccountName", uid)
    # IO.puts(search_results)
    case search_results do
      [] -> {:error, "Cant find user"}
      _ -> search_results |> Enum.fetch(0)
    end
  end



  def to_map(entry) do
    username = Exldap.search_attributes(entry, "sAMAccountName")
    name = Exldap.search_attributes(entry, "cn")
    email = Exldap.search_attributes(entry, "userPrincipalName")
    %{username: username, name: name, email: email}
  end
  


  def new_auth(uid, password) do
    {:ok, ldap_conn} = Exldap.open("172.16.170.10", 389, false)   
    case Exldap.verify_credentials(ldap_conn, "#{uid}@ad.iiw.org", password) do
      :ok -> :ok
      _ -> {:error, "Invalid username / password"}
    end
  end

end