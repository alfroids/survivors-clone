@icon("sword.png")
class_name Hitbox
extends Area2D
## Hitbox node.


signal dealt_damage()

@export var damage_data: DamageData


func _ready() -> void:
	area_entered.connect(_on_hurtbox_entered)

func _on_hurtbox_entered(hurtbox: Hurtbox) -> void:
	if not hurtbox:
		return

	hurtbox.take_damage(damage_data)
	dealt_damage.emit()
