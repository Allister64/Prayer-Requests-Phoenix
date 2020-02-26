defmodule PrayerRequestsWeb.PageController do
  use PrayerRequestsWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/login")
  end

  def secret(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    redirect(conn, to: "/requests")
  end
end
