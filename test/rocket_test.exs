defmodule RocketTest do
  use ExUnit.Case
  doctest Rocket

  test "create rocket properties" do
    assert Rocket.create(0, 25000, :earth) == %Rocket{fuel: 0, gravity: :earth, mass: 25000}
  end

  test "create errors if invalid properties" do
    invalid_mass = {:error, "invalid mass"}
    invalid_gravity = {:error, "invalid gravity"}
  
    assert Rocket.create(0, :invalid, :earth) == invalid_mass
    assert Rocket.create(0, 45, :invalid) == invalid_gravity
  end

  test "simulate fueling instructions" do
    assert Rocket.create(0, 45, :mars) |> Rocket.simulate("B") ==
      %Rocket{fuel: -25.98621, gravity: :mars, mass: 45}

    assert Rocket.create(0, 28801, :mars) |> Rocket.simulate("A") ==
      %Rocket{fuel: 3485.0568630000002, gravity: :mars, mass: 28801}
  end

end
