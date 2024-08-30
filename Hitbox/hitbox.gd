@icon("sword.png")
class_name Hitbox
extends Area2D
## Hitbox node.


signal applied_tick()
signal applied_last_tick()

@export var damage_data: DamageData

@onready var count_ticks: int = 0


func _ready() -> void:
	area_entered.connect(_on_hurtbox_entered)


func _on_hurtbox_entered(hurtbox: Hurtbox) -> void:
	if not hurtbox:
		return

	hurtbox.take_damage(damage_data)
	set_deferred(&"monitoring", false)

	if damage_data.total_ticks:
		count_ticks += 1
		if count_ticks < damage_data.total_ticks:
			applied_tick.emit()
			get_tree().create_timer(damage_data.tick_period).timeout.connect(set_deferred.bind(&"monitoring", true))
		else:
			applied_last_tick.emit()
	else:
		applied_tick.emit()
		get_tree().create_timer(damage_data.tick_period).timeout.connect(set_deferred.bind(&"monitoring", true))
