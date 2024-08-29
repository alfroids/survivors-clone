extends CharacterBody2D


@export var health_points: int = 100
@export var move_speed: float = 200.0


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
