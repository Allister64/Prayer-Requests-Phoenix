defmodule PrayerRequestsWeb.Router do
  use PrayerRequestsWeb, :router


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # Our pipeline implements "maybe" authenticated. We'll use the `:ensure_auth` below for when we need to make sure someone is logged in.
  pipeline :auth do
    plug PrayerRequests.UserManager.Pipeline
  end

  # We use ensure_auth to fail if there is no one logged in
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end


  # Maybe logged in routes
  # Maybe logged in routes
  scope "/", PrayerRequestsWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index
    get "/export", ExportController, :one
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :logout
  end

  scope "/", PrayerRequestsWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/secret", PageController, :secret
    resources "/requests", RequestController
    get "/test", ExportController, :index
    get "/login", LoginController, :index


  end

  # Other scopes may use custom stacks.
  # scope "/api", PrayerRequestsWeb do
  #   pipe_through :api
  # end
end
