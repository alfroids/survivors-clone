class_name Player
extends CharacterBody2D


signal leveled_up(new_level: int, xp_to_next_level: int)
signal current_xp_changed(new_current_xp: int)

#enum STATS {
	#HEALTH,
	#ARMOR,
	#MOVE_SPEED,
	#ATTACK_DAMAGE_MULTIPLIER,
	#ATTACK_SPEED_MULTIPLIER,
	#FIREBALL,
#}

@export var move_speed: float = 200.0

@onready var health_component: HealthComponent = $HealthComponent as HealthComponent
@onready var total_xp: int = 0
@onready var current_xp: int = 0
@onready var level: int = 1


func _ready() -> void:
	leveled_up.connect(SignalBus._on_player_leveled_up)
	current_xp_changed.connect(SignalBus._on_player_current_xp_changed)

	leveled_up.emit(level, 1000)


func _physics_process(_delta: float) -> void:
	var move_x: float = Input.get_action_strength(&"move_right") - Input.get_action_strength(&"move_left")
	var move_y: float = Input.get_action_strength(&"move_down") - Input.get_action_strength(&"move_up")
	var move_dir: Vector2 = Vector2(move_x, move_y).normalized()

	velocity = move_speed * move_dir

	move_and_slide()


func _on_hurtbox_received_damage(damage_data: DamageData) -> void:
	var _died: bool = health_component.take_damage(damage_data.damage_per_tick)


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
