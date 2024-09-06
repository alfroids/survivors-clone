extends State


@export var move_speed: float
@export var idle_state: State
@export var attack_state: State

@onready var entity: Enemy = owner as Enemy
@onready var attack_range: float = (($"../../Hitbox/CollisionShape2D" as CollisionShape2D).shape as CircleShape2D).radius


## Called when this State is being activated.
func enter(_msg: Dictionary = {}) -> void:
	pass


## Called when this State is being deactivated.
func exit() -> void:
	pass


## Intended to handle input events from its [class StateMachine].
func handle_input(_event: InputEvent) -> void:
	pass


## Intended to handle idle processes from its [class StateMachine].
func update(_delta: float) -> void:
	pass


## Intended to handle physics processes from its [class StateMachine].
func physics_update(_delta: float) -> void:
	if not entity.target:
		change_state(idle_state)
		return

	if entity.global_position.distance_squared_to(entity.target.global_position) <= attack_range**2:
		change_state(attack_state)

	var move_dir: Vector2 = entity.global_position.direction_to(entity.target.global_position)
	entity.velocity = move_speed * move_dir
	entity.move_and_slide()
