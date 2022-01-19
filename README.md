# police-vehicleshop
this a easy code to made spawn was forked from dox spawn car for police 
-----------------------------------------------------------------------
-----------------------------------------------------------------------
```
 # qb-target
 ```
 ```
Config.Peds = {
	[1] = {
		model = 'ig_trafficwarden',
		coords = vector4(458.49, -1017.2, 28.22, 90.82),
		minusOne = true,
		freeze = true,
		invincible = true,
		blockevents = true,
        animDict = 'abigail_mcs_1_concat-0',
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		flag = 1,
		target = {
			options = {
				{
					type = "client",
					event = "police:client:menu",
					icon = 'fas fa-car',
					label = 'police garage',
					job = 'police',
				}
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
}
```
