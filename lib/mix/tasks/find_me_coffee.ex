defmodule Mix.Tasks.FindMeCoffee do
  @moduledoc "To get a list of open trucks serving coffee run: `mix find_me_coffee`"

  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")

    case TruckClient.list_trucks() do
      :error ->
        IO.puts("Could not find you coffee today.")

      all_trucks ->
        all_trucks
        |> Enum.filter(&has_coffee?/1)
        |> show_todays_coffee()
    end
  end

  defp has_coffee?(truck) do
    truck["fooditems"] && truck["fooditems"] =~ "coffee"
  end

  defp show_todays_coffee([]), do: IO.puts("None of today's trucks are serving coffee.")

  defp show_todays_coffee(coffee_trucks) do
    Enum.each(
      coffee_trucks,
      fn truck ->
        IO.puts(truck["applicant"])
        IO.puts(truck["address"])
        IO.puts(truck["fooditems"])
        IO.puts("=========")
      end
    )
  end
end
