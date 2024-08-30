class_name Fireball
extends Node2D


const SPEED: float = 800.0

var direction: Vector2


func _physics_process(delta: float) -> void:
	position += delta * SPEED * direction
