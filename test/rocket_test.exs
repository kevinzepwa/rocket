defmodule RocketTest do
  use ExUnit.Case
  doctest Rocket

  test "final_fuel" do
    assert Rocket.total_fuel(28801, [
             {:launch, 9.807},
             {:land, 1.62},
             {:launch, 1.62},
             {:land, 9.807}
           ]) == 36778
  end
end
