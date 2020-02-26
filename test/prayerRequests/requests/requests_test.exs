defmodule PrayerRequests.RequestsTest do
  use PrayerRequests.DataCase

  alias PrayerRequests.Requests

  describe "requests" do
    alias PrayerRequests.Requests.Request

    @valid_attrs %{name: "some name", original_request: "some original_request", place: "some place", sanitized_request: "some sanitized_request"}
    @update_attrs %{name: "some updated name", original_request: "some updated original_request", place: "some updated place", sanitized_request: "some updated sanitized_request"}
    @invalid_attrs %{name: nil, original_request: nil, place: nil, sanitized_request: nil}

    def request_fixture(attrs \\ %{}) do
      {:ok, request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Requests.create_request()

      request
    end

    test "list_requests/0 returns all requests" do
      request = request_fixture()
      assert Requests.list_requests() == [request]
    end

    test "get_request!/1 returns the request with given id" do
      request = request_fixture()
      assert Requests.get_request!(request.id) == request
    end

    test "create_request/1 with valid data creates a request" do
      assert {:ok, %Request{} = request} = Requests.create_request(@valid_attrs)
      assert request.name == "some name"
      assert request.original_request == "some original_request"
      assert request.place == "some place"
      assert request.sanitized_request == "some sanitized_request"
    end

    test "create_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Requests.create_request(@invalid_attrs)
    end

    test "update_request/2 with valid data updates the request" do
      request = request_fixture()
      assert {:ok, %Request{} = request} = Requests.update_request(request, @update_attrs)
      assert request.name == "some updated name"
      assert request.original_request == "some updated original_request"
      assert request.place == "some updated place"
      assert request.sanitized_request == "some updated sanitized_request"
    end

    test "update_request/2 with invalid data returns error changeset" do
      request = request_fixture()
      assert {:error, %Ecto.Changeset{}} = Requests.update_request(request, @invalid_attrs)
      assert request == Requests.get_request!(request.id)
    end

    test "delete_request/1 deletes the request" do
      request = request_fixture()
      assert {:ok, %Request{}} = Requests.delete_request(request)
      assert_raise Ecto.NoResultsError, fn -> Requests.get_request!(request.id) end
    end

    test "change_request/1 returns a request changeset" do
      request = request_fixture()
      assert %Ecto.Changeset{} = Requests.change_request(request)
    end
  end
end
