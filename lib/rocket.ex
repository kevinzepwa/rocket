defmodule Rocket do
  @moduledoc """
  Documentation for `Rocket`.
  """
  @doc """
  Creating the Rocket properties: Starting fuel (default given as 0), its mass in kgs and the gravity of the planet involved. The guard clauses will ensure correct input.
  """
  defstruct [:fuel, :mass, :gravity]

  defguard is_fuel(fuel)
           when is_integer(fuel) or is_float(fuel)

  defguard is_mass(mass)
           when is_integer(mass) or is_float(mass)

  defguard is_gravity(gravity)
           when gravity in [:earth, :moon, :mars]

  def create(fuel \\ 0, mass \\ 0, gravity \\ 0)

  def create(_, mass, _) when not is_mass(mass), do: {:error, "invalid mass"}

  def create(_, _, gravity) when not is_gravity(gravity), do: {:error, "invalid gravity"}

  def create(fuel, mass, gravity), do: %Rocket{fuel: fuel, mass: mass, gravity: gravity}

  # returns the new final fuel needed in a stepwise fashion including the additional fuel
  def final do
    %__MODULE__{}
  end

  def final(rocket, status, k) when k > 0 do
    list = []

    sortit = %__MODULE__{
      rocket
      | fuel: rocket.fuel + add_fuel(rocket.mass, rocket.gravity, status),
        mass: add_fuel(rocket.mass, rocket.gravity, status)
    }

    IO.inspect(list ++ [rocket.fuel + add_fuel(rocket.mass, rocket.gravity, status)])

    final(sortit, status, k - 1)
  end

  def final(rocket, status, 0) do
    :ok
  end

  @doc """
  Use a pattern matching algorith to get the fuel based on gravity
  """
  # landing
  def add_fuel(mass, :earth, "A"), do: (mass * 9.807 * 0.033 - 42) |> trunc()

  def add_fuel(mass, :moon, "A"),
    do:
      (mass * 1.62 * 0.033 - 42 + (mass * 9.807 * 0.042 - 33) + (mass * 9.807 * 0.033 - 42))
      |> trunc()

  def add_fuel(mass, :mars, "A"),
    do:
      (mass * 3.711 * 0.033 - 42 + (mass * 9.807 * 0.042 - 33) + (mass * 9.807 * 0.033 - 42))
      |> trunc()

  # launching
  def add_fuel(mass, :earth, "B"), do: (mass * 9.807 * 0.042 - 33) |> trunc()
  def add_fuel(mass, :moon, "B"), do: (mass * 1.62 * 0.042 - 33) |> trunc()
  def add_fuel(mass, :mars, "B"), do: (mass * 3.711 * 0.042 - 33) |> trunc()
end

# example for Apollo 11 Command and Service Module, with a weight of 28801 kg, to land it on the Earth, the required amount of fuel will be:
# Rocket.create(0, 28801, :earth) |> Rocket.simulate("A") →  9278

# for Apollo 11 CSM to launch from moon:
# Rocket.create(0, 28801, :moon) |> Rocket.Simulate.simulate("B") → 1926

# Rocket.create(0, 28801, :moon) |> Rocket.Apply_status.to_fuel("B") → %Rocket{fuel: 1926, gravity: :moon, mass: 1926}

# Rocket.create(0, 28801, :earth) |> Rocket.final("A", 1) → [9278]  ...returns first fuel value

# Rocket.create(0, 28801, :earth) |> Rocket.final("A", 5) → 9278, 12238, 13153, 13407,13447, :ok    ....the last value needed is 13447

# ...remaining how to extract the larget value from the list.
