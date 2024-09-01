extends CharacterBody2D


signal leveled_up(new_level: int, xp_to_next_level: int)
signal current_xp_changed(new_current_xp: int)

@export var max_health: int = 100
@export var move_speed: float = 200.0
@export var fireball_scene: PackedScene

@onready var health_bar: ProgressBar = $HealthBar as ProgressBar
@onready var health: int = max_health:
	set(h):
		health = clampi(h, 0, max_health)
		health_bar.value = health
@onready var total_xp: int = 0
@onready var current_xp: int = 0
@onready var level: int = 1


func _ready() -> void:
	leveled_up.connect(SignalBus._on_player_leveled_up)
	current_xp_changed.connect(SignalBus._on_player_current_xp_changed)

	health_bar.max_value = max_health
	health_bar.value = health

	leveled_up.emit(level, 1000)


func _physics_process(_delta: float) -> void:
	var move_x: float = Input.get_action_strength(&"move_right") - Input.get_action_strength(&"move_left")
	var move_y: float = Input.get_action_strength(&"move_down") - Input.get_action_strength(&"move_up")
	var move_dir: Vector2 = Vector2(move_x, move_y).normalized()

	velocity = move_speed * move_dir

	move_and_slide()


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
	fireball.position = position
	fireball.direction = direction
	fireball.top_level = true
	add_child(fireball)


func _on_hurtbox_received_damage(damage_data: DamageData) -> void:
	health -= damage_data.damage_per_tick


func _on_loot_range_area_entered(area: Area2D) -> void:
	if area is XP:
		var collected_xp: int = (area as XP).collect(self)
		total_xp += collected_xp
		current_xp += collected_xp

		while current_xp >= 1000:
			current_xp -= 1000
			level += 1
			leveled_up.emit(level, 1000)

		current_xp_changed.emit(current_xp)
