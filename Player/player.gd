extends CharacterBody2D


@export var health_points: int = 100
@export var move_speed: float = 200.0
@export var fireball_scene: PackedScene


func _physics_process(_delta: float) -> void:
	movement()


func movement() -> void:
	var move_x: float = Input.get_action_strength(&"move_right") \
						- Input.get_action_strength(&"move_left")
	var move_y: float = Input.get_action_strength(&"move_down") \
						- Input.get_action_strength(&"move_up")
	var move_dir: Vector2 = Vector2(move_x, move_y).normalized()

	velocity = move_speed * move_dir

	move_and_slide()


func autoshoot() -> void:
	var closest_enemy: CharacterBody2D
	var closest_distsq: float

	for enemy: CharacterBody2D in get_tree().get_nodes_in_group(&"enemies"):
		var enemy_distsq: float = global_position.distance_squared_to(enemy.global_position)
		if not closest_enemy or enemy_distsq < closest_distsq:
			closest_enemy = enemy
			closest_distsq = enemy_distsq

	var direction: Vector2
	if closest_enemy:
		direction = global_position.direction_to(closest_enemy.global_position)
	else:
		direction = Vector2.RIGHT.rotated(randf() * 2 * PI)
	var fireball: Fireball = fireball_scene.instantiate() as Fireball
	fireball.position = position
	fireball.direction = direction
	fireball.top_level = true
	add_child(fireball)
