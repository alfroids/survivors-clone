class_name Enemy
extends CharacterBody2D


@export var enemy_data: EnemyData
@export var xp_scene: PackedScene

var max_health: int
var move_speed: float
var health: int:
	set(h):
		health = clampi(h, 0, max_health)
		health_bar.value = health

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group(&"player") as CharacterBody2D
@onready var health_bar: ProgressBar = $HealthBar as ProgressBar


func _ready() -> void:
	if enemy_data.texture:
		($Sprite2D as Sprite2D).texture = enemy_data.texture

	max_health = enemy_data.max_health
	move_speed = enemy_data.move_speed
	health = max_health

	($Hitbox as Hitbox).damage_data = enemy_data.damage_data

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
		@warning_ignore("integer_division")
		for i in range(enemy_data.xp_drop / 100):
			spawn_xp(100)
		spawn_xp(enemy_data.xp_drop % 100)

		queue_free()


func spawn_xp(xp_amount: int) -> void:
	if xp_amount <= 0:
		return

	var xp: XP = xp_scene.instantiate()
	xp.xp_amount = xp_amount
	xp.global_position = global_position + Utils.random_point_in_circle(50.0)
	get_tree().current_scene.call_deferred(&"add_child", xp)
