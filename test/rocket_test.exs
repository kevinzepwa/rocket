defmodule RocketTest do
  use ExUnit.Case
  doctest Rocket
  doctest Rocket.Simulate

  test "create rocket properties" do
    assert Rocket.create(0, 25000, :earth) == %Rocket{fuel: 0, gravity: :earth, mass: 25000}
  end

  test "create errors if invalid properties" do
    invalid_mass = {:error, "invalid mass"}
    invalid_gravity = {:error, "invalid gravity"}

    assert Rocket.create(0, :invalid, :earth) == invalid_mass
    assert Rocket.create(0, 45, :invalid) == invalid_gravity
  end
end
