# Rocket

Rocket is a sample NASA software for calculating fuel needed to launch and land a ship of given mass depending on the gravity of the planet.
Formula to calculate fuel is quite simple. The planets NASA is interested in are:

- Earth - 9.807 m/s2
- Moon - 1.62 m/s2
- Mars - 3.711 m/s2

The formula for fuel calculations for the launch is the following:

- mass _ gravity _ 0.042 - 33 rounded down

The formula for fuel calculations for the landing is the following:

- mass _ gravity _ 0.033 - 42 rounded down

But fuel adds weight to the ship, so it requires additional fuel, until additional fuel is 0 or negative. Therefore, this software does the heavy lifting by simplifing this recursive process and gives you the required total fuel for a full mission.

For instance, a program to launch the ship from the Earth, land it on the Moon, and return back to the Earth, you will run:

```
> Rocket.total_fuel(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
```

, and the output will be → 36778.
