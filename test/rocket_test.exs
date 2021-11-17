defmodule RocketTest do
  use ExUnit.Case
  doctest Rocket
  doctest Rocket.Fuel

  test "total_final_fuel_to_moon" do
    assert Rocket.total_fuel(28801, [
             {:launch, 9.807},
             {:land, 1.62},
             {:launch, 1.62},
             {:land, 9.807}
           ]) == 36778
  end

  test "total_final_fuel_to_mars" do
    assert Rocket.total_fuel(75432, [
             {:launch, 9.807},
             {:land, 3.711},
             {:launch, 3.711},
             {:land, 9.807}
           ]) == 112_212
  end

  test "total_final_fuel_to_moon_and_mars" do
    assert Rocket.total_fuel(75432, [
             {:launch, 9.807},
             {:land, 1.62},
             {:launch, 1.62},
             {:land, 3.711},
             {:launch, 3.711},
             {:land, 9.807}
           ]) == 121_785
  end
end
