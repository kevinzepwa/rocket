defmodule RocketTest do
  use ExUnit.Case
  doctest Rocket

  test "create rocket properties" do
    assert Rocket.create(0, 250, 10.2) == %Rocket{fuel: 0, mass: 250, gravity: 10.2}
  end

  test "create errors if invalid properties" do
    invalid_mass = {:error, "invalid mass"}
   
    assert Rocket.create(:full_tank, :invalid, :gravity) == invalid_mass
   end

  #to be modified for flexible g.
  test "simulate fueling instructions" do
    assert Rocket.create(0, 50, 11) |> Rocket.simulate("B") ==
      %Rocket{fuel: -12.0, mass: 50, gravity: 11}
  end
end
