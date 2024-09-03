extends Node2D


@export_range(0.0, 5.0, 0.1, "or_greater", "suffix:/s") var attack_speed: float = 1.0

@onready var fireball_scene: PackedScene = preload("res://Fireball/fireball.tscn")


func _ready() -> void:
	var shoot_timer: Timer = $ShootTimer as Timer
	shoot_timer.wait_time = 1 / attack_speed
	shoot_timer.start()


func _on_shoot_timer_timeout() -> void:
	var closest_enemy: CharacterBody2D
	var closest_distsq: float = INF

	for enemy: CharacterBody2D in get_tree().get_nodes_in_group(&"enemies"):
		var enemy_distsq: float = global_position.distance_squared_to(enemy.global_position)
		if enemy_distsq < closest_distsq:
			closest_enemy = enemy
			closest_distsq = enemy_distsq

	if not closest_enemy:
		return

	var direction: Vector2 = global_position.direction_to(closest_enemy.global_position)
	var fireball: Fireball = fireball_scene.instantiate() as Fireball
	fireball.global_position = global_position
	fireball.direction = direction
	get_tree().current_scene.call_deferred(&"add_child", fireball)
