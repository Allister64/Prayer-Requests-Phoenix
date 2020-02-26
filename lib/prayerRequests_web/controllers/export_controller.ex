defmodule PrayerRequestsWeb.ExportController do
  use PrayerRequestsWeb, :controller

  alias PrayerRequests.Requests
  alias PrayerRequests.Requests.Request

  def index(conn, _params) do
    conn = put_layout conn, false
    requests = PrayerRequests.Requests.Request
    |> PrayerRequests.Repo.all()
    render(conn, "index.xml", requests: requests)
  end

  def one(conn, _params) do
    highest = Requests.highest_count()
    request = Requests.return_one(highest)

    # case highest do
    #   nil -> request = Requests.return_one()
    #   _ -> request = Requests.return_highest(highest)
    # end

    render(conn, "one.xml", request: request)
  end

end