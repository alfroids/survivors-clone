class_name HurtBox
extends Area2D


signal received_damage(dmg: int)
signal received_fatal_damage(dmg: int)

@export_flags("Alies", "Enemies", "Environment") var hit_layer: int = 0
@export var health: int = 1:
	set(h):
		health = maxi(h, 0)
@export var is_invulnerable: bool = false

@onready var buffer_timer: Timer = $BufferTimer as Timer


func take_damage(dmg: int) -> void:
	if is_invulnerable:
		return

	health -= dmg

	if health:
		received_damage.emit(dmg)
	else:
		received_fatal_damage.emit(dmg)

	monitorable = false
	buffer_timer.start()

func _on_buffer_timer_timeout() -> void:
	monitorable = true
