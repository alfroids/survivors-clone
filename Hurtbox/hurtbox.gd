@icon("shield.png")
class_name Hurtbox
extends Area2D
## Hurtbox node.


signal received_damage(damage_data: DamageData)

const BUFFER_TIME: float = 0.5


func take_damage(damage_data: DamageData) -> void:
	received_damage.emit(damage_data)
	set_deferred(&"monitorable", false)
	get_tree().create_timer(BUFFER_TIME).timeout.connect(set_deferred.bind(&"monitorable", true))
