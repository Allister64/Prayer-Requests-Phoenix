defmodule PrayerRequests.Requests.Request do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query



  schema "requests" do
    field :name, :string
    field :original_request, :string
    field :place, :string
    field :sanitized_request, :string
    field :count, :integer

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [:name, :place, :original_request, :sanitized_request])
    |> validate_required([:name, :place, :original_request, :sanitized_request])
  end




  # def order_by(query, list) when  is_nil(list) or byte_size(list) == 0 do
  #   query
  # end
  # def order_by(query, list) do
  #   from result in query,
  #   order_by: [desc: :name]
  # end


  def search(query, search_term) do
    wildcard_search = "%#{search_term}%"

    from request in query,
    where: like(request.name, ^wildcard_search),
    or_where: like(request.original_request, ^wildcard_search),
    or_where: like(request.place, ^wildcard_search),
    or_where: like(request.sanitized_request, ^wildcard_search)
  end 

end
