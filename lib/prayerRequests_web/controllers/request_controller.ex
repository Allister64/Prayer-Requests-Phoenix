defmodule PrayerRequestsWeb.RequestController do
  use PrayerRequestsWeb, :controller

  alias PrayerRequests.Requests
  alias PrayerRequests.Requests.Request

  # def index(conn, params) do  
  #   page = PrayerRequests.Requests.Request 
  #   |> PrayerRequests.Repo.paginate(params)
  #   render(conn, "index.html", requests: page.entries, page: page)
  # end

  # def index(conn, params) do
  #   requests = Requests.list_requests(params)
  #   render(conn, "index.html", requests: requests)
  # end

  def index(conn, params) do
    page = Requests.list_requests(params)
    |> PrayerRequests.Repo.paginate(params)
    render(conn, "index.html", requests: page.entries, page: page)
  end

  def new(conn, _params) do
    changeset = Requests.change_request(%Request{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"request" => request_params}) do
    case Requests.create_request(request_params) do
      {:ok, request} ->
        conn
        |> put_flash(:info, "Request created successfully.")
        |> redirect(to: Routes.request_path(conn, :show, request))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    request = Requests.get_request!(id)
    render(conn, "show.html", request: request)
  end

  def edit(conn, %{"id" => id}) do
    request = Requests.get_request!(id)
    changeset = Requests.change_request(request)
    render(conn, "edit.html", request: request, changeset: changeset)
  end

  def update(conn, %{"id" => id, "request" => request_params}) do
    request = Requests.get_request!(id)

    case Requests.update_request(request, request_params) do
      {:ok, request} ->
        conn
        |> put_flash(:info, "Request updated successfully.")
        |> redirect(to: Routes.request_path(conn, :show, request))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", request: request, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    request = Requests.get_request!(id)
    {:ok, _request} = Requests.delete_request(request)

    conn
    |> put_flash(:info, "Request deleted successfully.")
    |> redirect(to: Routes.request_path(conn, :index))
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"
  
      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]
  
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML
      use Phoenix.HTML.SimplifiedHelpers  # <- this line.
  
      import MyApp.Router.Helpers
      import MyApp.ErrorHelpers
      import MyApp.Gettext
    end
  end


end
