defmodule PrayerRequests.Requests do
  @moduledoc """
  The Requests context.
  """
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias PrayerRequests.Repo

  alias PrayerRequests.Requests.Request


  @doc """
  Returns the list of requests.

  ## Examples

0142      iex> list_requests()
      [%Request{}, ...]

  """
  def list_requests(params) do
    search_term = get_in(params, ["query"])
    Request
    |> Request.search(search_term)
  end

  def highest_count() do
    request = 
      Request
      # |> where([r], r.count > 0)
      |> select([r], r.count)
      |> order_by(desc: :count)
      |> limit(1)
      |> Repo.one()
  end

# count does not represent how many times called, just a way to call newest
# request and move it to the back of the queue

  def return_one(highest) do  
    request = 
      Request
      |> order_by(asc: :count)
      |> limit(1)
      |> Repo.one()

    if highest == 0 do
      request
      |> change(count: request.count + 1)
      |> Repo.update!()
    end
    if highest > 0 do
      request
      |> change(count: (highest + 1))
      |> Repo.update!()
    end
  end


  @doc """
  Gets a single request.

  Raises `Ecto.NoResultsError` if the Request does not exist.

  ## Examples

      iex> get_request!(123)
      %Request{}

      iex> get_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_request!(id), do: Repo.get!(Request, id)

  @doc """
  Creates a request.

  ## Examples

      iex> create_request(%{field: value})
      {:ok, %Request{}}

      iex> create_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_request(attrs \\ %{}) do
    %Request{}
    |> Request.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a request.

  ## Examples

      iex> update_request(request, %{field: new_value})
      {:ok, %Request{}}

      iex> update_request(request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_request(%Request{} = request, attrs) do
    request
    |> Request.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Request.

  ## Examples

      iex> delete_request(request)
      {:ok, %Request{}}

      iex> delete_request(request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_request(%Request{} = request) do
    Repo.delete(request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking request changes.

  ## Examples

      iex> change_request(request)
      %Ecto.Changeset{source: %Request{}}

  """
  def change_request(%Request{} = request) do
    Request.changeset(request, %{})
  end
end
