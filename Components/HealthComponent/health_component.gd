class_name HealthComponent
extends Node2D


@export_range(1.0, 100.0, 1.0, "or_greater") var max_health: float = 10.0:
	set(mh):
		max_health = maxf(0.0, mh)
		health_bar.max_value = max_health
@export var allow_shield: bool = false

var lost_health: float:
	get:
		return max_health - health

@onready var health_bar: ProgressBar = $HealthBar as ProgressBar
@onready var health: float = max_health:
	set(h):
		health = clampf(h, 0.0, max_health)
		health_bar.value = health
@onready var armor: float = 0.0:
	set(a):
		armor = maxf(0.0, a)
@onready var shield: float = 0.0:
	set(s):
		shield = maxf(0.0, s)


func _ready() -> void:
	health_bar.max_value = max_health
	health_bar.value = health


func take_damage(damage: float, ignore_shield: bool = false) -> bool:
	if not ignore_shield:
		var excess_damage: float = maxf(0.0, damage - shield)
		shield -= damage
		damage = excess_damage

	health -= damage / (1 + armor / 25.0)

	return not health


func heal(heal_amount: float, excess_to_shield: bool = false) -> void:
	if excess_to_shield:
		var excess_heal: float = heal_amount - lost_health
		shield += excess_heal

	health += heal_amount
