extends CharacterBody2D


@export var max_health: int = 10
@export var move_speed: float = 100.0

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group(&"player") as CharacterBody2D
@onready var health_bar: ProgressBar = $HealthBar as ProgressBar
@onready var health: int = max_health:
	set(h):
		health = clampi(h, 0, max_health)
		health_bar.value = health


func _ready() -> void:
	health_bar.max_value = max_health
	health_bar.value = health


func _physics_process(_delta: float) -> void:
	movement()


func movement() -> void:
	var move_dir: Vector2 = global_position.direction_to(player.global_position)
	velocity = move_speed * move_dir
	move_and_slide()


func _on_hurtbox_received_damage(damage_data: DamageData) -> void:
	health -= damage_data.damage_per_tick
	if not health:
		queue_free()
