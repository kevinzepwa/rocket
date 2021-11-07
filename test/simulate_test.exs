defmodule SimulateTest do
  use ExUnit.Case
  import Rocket
  import Rocket.Simulate

  test "simulate fueling instructions" do
    assert Rocket.create(0, 45, :mars)
           |> Rocket.Simulate.simulate("B") == -25

    assert Rocket.create(0, 28801, :mars)
           |> Rocket.Simulate.simulate("A") == 24593

    assert Rocket.Simulate.simulate(%Rocket{fuel: 0, gravity: :earth, mass: 25000}, "A") == 8048
  end
end
