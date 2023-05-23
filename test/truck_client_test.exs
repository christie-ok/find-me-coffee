defmodule TruckClientTest do
  use ExUnit.Case

  describe "get_path/0" do
    test "sends get request" do
      Tesla.Mock.mock(fn
        %{method: :get} ->
          %Tesla.Env{status: 200, body: "list of trucks"}
      end)

      assert {:ok,
              %Tesla.Env{
                body: "list of trucks",
                status: 200
              }} = TruckClient.get_path()
    end
  end

  describe "list_trucks" do
    test "returns list of trucks if get request is successful" do
      Tesla.Mock.mock(fn
        %{method: :get} ->
          %Tesla.Env{status: 200, body: ["truck 1", "truck 2"]}
      end)

      assert ["truck 1", "truck 2"] == TruckClient.list_trucks()
    end

    test "returns :error if get request not successful" do
      Tesla.Mock.mock(fn
        %{method: :get} ->
          %Tesla.Env{status: 504, body: []}
      end)

      assert :error == TruckClient.list_trucks()
    end
  end
end
