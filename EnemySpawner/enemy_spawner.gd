extends Path2D


@export var enemy_scene: PackedScene

@onready var spawn_timer: Timer = $SpawnTimer as Timer
@onready var spawn_location: PathFollow2D = $SpawnLocation as PathFollow2D


func _on_spawn_timer_timeout() -> void:
	spawn_location.progress_ratio = randf()

	var enemy: Enemy = enemy_scene.instantiate() as Enemy
	enemy.global_position = spawn_location.global_position
	enemy.top_level = true
	add_child(enemy)

	spawn_timer.start(randf_range(2.0, 6.0))
