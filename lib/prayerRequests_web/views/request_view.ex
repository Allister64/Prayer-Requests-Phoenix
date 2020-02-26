defmodule PrayerRequestsWeb.RequestView do
  use PrayerRequestsWeb, :view
  import Scrivener.HTML
  import Phoenix.HTML.SimplifiedHelpers.Truncate        # <- this line.

  # def order_by_list do
  #   [Newest, Oldest, Name, Place]
  # end
end
