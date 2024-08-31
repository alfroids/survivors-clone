class_name XP
extends Area2D


@export var xp_amount: int = 0
@export var hue_curve: Curve

var target: Node2D

@onready var speed: float = 0.0


func _ready() -> void:
	var hue: float = hue_curve.sample(xp_amount / 100.0)
	($Sprite2D as Sprite2D).material.set(&"shader_parameter/XPColor", hue)


func _physics_process(delta: float) -> void:
	if target:
		speed += 4 * delta
		global_position = global_position.move_toward(target.global_position, speed)

		if global_position.distance_squared_to(target.global_position) <= 100.0:
			queue_free()


func collect(player: CharacterBody2D) -> int:
	target = player
	($CollisionShape2D as CollisionShape2D).set_deferred(&"disabled", true)
	return xp_amount
