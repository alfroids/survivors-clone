class_name DamageData
extends Resource


@export_range(0, 50, 1, "or_greater") var damage_per_tick: int = 1
@export_range(0, 5, 1) var total_ticks: int = 1
@export_range(0.0, 5.0, 0.1, "suffix:ticks/s") var ticks_frequency: float = 2.0

var tick_period: float:
	get:
		return 1 / ticks_frequency
