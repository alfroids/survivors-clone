class_name HitBox
extends Area2D


signal dealt_damage(dmg: int)

@export_flags("Alies", "Enemies", "Environment") var hit_mask: int = 0
@export var max_hits: int = 1:
	set(mh):
		max_hits = maxi(mh, 0)
@export var damage: int = 1:
	set(d):
		damage = maxi(d, 0)

@onready var count_hits: int = 0


func _on_hurtbox_entered(hurtbox: HurtBox) -> void:
	if not hurtbox.hit_layer & hit_mask:
		return

	hurtbox.take_damage(damage)
	dealt_damage.emit(damage)
	count_hits += 1

	if max_hits and count_hits >= max_hits:
		queue_free()  # TODO
