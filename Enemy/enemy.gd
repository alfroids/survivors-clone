class_name Enemy
extends CharacterBody2D


@export var xp_drop: int = 50
@export var xp_scene: PackedScene

@onready var target: Player = get_tree().get_first_node_in_group(&"player") as Player
@onready var health_component: HealthComponent = $HealthComponent as HealthComponent
@onready var state_machine: StateMachine = $StateMachine as StateMachine


func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)


func _on_hurtbox_received_damage(damage_data: DamageData) -> void:
	var died: bool = health_component.take_damage(damage_data.damage_per_tick)

	if died:
		@warning_ignore("integer_division")
		for i in range(xp_drop / 100):
			spawn_xp(100)
		spawn_xp(xp_drop % 100)

		queue_free()


func spawn_xp(xp_amount: int) -> void:
	if xp_amount <= 0:
		return

	var xp: XP = xp_scene.instantiate()
	xp.xp_amount = xp_amount
	xp.global_position = global_position + Utils.random_point_in_circle(50.0)
	get_tree().current_scene.call_deferred(&"add_child", xp)
