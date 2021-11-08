defmodule Rocket.Fuel do
  @moduledoc """
  Documentation for `Calculate`.
  """
  @doc """
  The recursion logic
  Calculates the fuel required for the launch and land at the destination planet
  ## Examples
      iex> Rocket.Fuel.destination_launch_fuel(28801, 1.62)
      2024
      iex> Rocket.Fuel.destination_land_fuel(28801, 1.62)
      1535
  """
  def destination_launch_fuel(mass, destination_gravity) do
    initial_fuel = initial_fuel(mass, destination_gravity, 0.042, 33)
    calculate_fuel({initial_fuel, initial_fuel}, destination_gravity, 0.042, 33)
  end

  def destination_land_fuel(mass, destination_gravity) do
    initial_fuel = initial_fuel(mass, destination_gravity, 0.033, 42)
    calculate_fuel({initial_fuel, initial_fuel}, destination_gravity, 0.033, 42)
  end

  @doc """
  Calculates the fuel required for the launch and land at the start planet i.e return planet
  ## Examples
      iex> Rocket.Fuel.return_launch_fuel(28801, 9.807)
      19772
      iex> Rocket.Fuel.return_land_fuel(28801, 9.807)
      13447
  """
  def return_launch_fuel(mass, return_gravity) do
    initial_fuel = initial_fuel(mass, return_gravity, 0.042, 33)
    calculate_fuel({initial_fuel, initial_fuel}, return_gravity, 0.042, 33)
  end

  def return_land_fuel(mass, return_gravity) do
    initial_fuel = initial_fuel(mass, return_gravity, 0.033, 42)
    calculate_fuel({initial_fuel, initial_fuel}, return_gravity, 0.033, 42)
  end

  defp calculate_fuel({_last_fuel, current_fuel}, _gravity, _const_1, _const_2)
      when current_fuel <= 0 do
    0
  end

  defp calculate_fuel({_last_fuel, current_fuel}, gravity, const_1, const_2) do
    returned_fuel = trunc(current_fuel * gravity * const_1 - const_2)
    current_fuel + calculate_fuel({current_fuel, returned_fuel}, gravity, const_1, const_2)
  end

  defp initial_fuel(mass, gravity, const_1, const_2) do
    (mass * gravity * const_1 - const_2)
    |> trunc()
  end
end
