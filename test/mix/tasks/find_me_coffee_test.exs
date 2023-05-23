defmodule Mix.Tasks.FindMeCoffeeTest do
  use ExUnit.Case

  alias Mix.Tasks.FindMeCoffee

  @taco_truck %{
    "applicant" => "Off the Grid Services, LLC",
    "address" => "10 California Street",
    "fooditems" => "tacos"
  }

  @coffee_truck %{
    "applicant" => "Caffine Cart",
    "address" => "50 Powell Street",
    "fooditems" => "coffee"
  }

  @donut_truck %{
    "applicant" => "Mmmm... Donuts",
    "address" => "4 Embarcadero",
    "fooditems" => "donuts & coffee"
  }

  describe "run/1" do
    test "should display name, address, and food items for carts including coffee" do
      Tesla.Mock.mock(fn
        %{method: :get} ->
          %Tesla.Env{status: 200, body: [@taco_truck, @coffee_truck, @donut_truck]}
      end)

      assert ExUnit.CaptureIO.capture_io(fn -> FindMeCoffee.run([]) end) ==
               "Caffine Cart\n50 Powell Street\ncoffee\n=========\nMmmm... Donuts\n4 Embarcadero\ndonuts & coffee\n=========\n"
    end

    test "should display error message if API request unsuccessful" do
      Tesla.Mock.mock(fn
        %{method: :get} ->
          %Tesla.Env{status: 504}
      end)

      assert ExUnit.CaptureIO.capture_io(fn -> FindMeCoffee.run([]) end) ==
               "Could not find you coffee today.\n"
    end

    test "should display message that no coffee cards are found if API call is successful, but no carts have coffee" do
      Tesla.Mock.mock(fn
        %{method: :get} ->
          %Tesla.Env{status: 200, body: [@taco_truck]}
      end)

      assert ExUnit.CaptureIO.capture_io(fn -> FindMeCoffee.run([]) end) ==
               "None of today's trucks are serving coffee.\n"
    end
  end
end
