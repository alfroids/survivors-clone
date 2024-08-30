extends CharacterBody2D


@export var health_points: int = 10
@export var move_speed: float = 100.0

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group(&"player") as CharacterBody2D


func _physics_process(_delta: float) -> void:
	movement()


func movement() -> void:
	var move_dir: Vector2 = global_position.direction_to(player.global_position)
	velocity = move_speed * move_dir
	move_and_slide()


func _on_hurtbox_received_damage(damage_data: DamageData) -> void:
	health_points -= damage_data.damage_per_tick
	if health_points <= 0:
		queue_free()
