defmodule Rocket do
  import Rocket.Fuel

  @moduledoc """
  Documentation for `Rocket`.
  """
  @doc """
  Calculates the total fuel required to complete the mission
  ## Example
      iex> Rocket.total_fuel(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
      36778
  """
  @spec total_fuel(float(), [
          {:launch, float()},
          {:land, float()},
          {:launch, float()},
          {:land, float()}
        ]) :: integer()
  def total_fuel(mass, [
        {:launch, return_gravity},
        {:land, destination_gravity},
        {:launch, destination_gravity},
        {:land, return_gravity}
      ]) do
    destination_launch_fuel(mass, destination_gravity) +
      destination_land_fuel(mass, destination_gravity) + return_launch_fuel(mass, return_gravity) +
      return_land_fuel(mass, return_gravity)
  end
end
