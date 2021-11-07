defmodule Rocket.Apply_status do
  import Rocket

  @doc """
  Apply the functionality for landing and launching.
  """
  def apply_status(rocket, status), do: add_fuel(rocket.mass, rocket.gravity, status)

  def fuel_and_mass(rocket, status),
    do: %{rocket | mass: rocket.mass + add_fuel(rocket.mass, rocket.gravity, status)}

  # returns new rocket mass and fuel
  def to_fuel(rocket, status),
    do: %{
      rocket
      | fuel: rocket.fuel + add_fuel(rocket.mass, rocket.gravity, status),
        mass: rocket.mass + add_fuel(rocket.mass, rocket.gravity, status)
    }
end
