extends Node


signal player_leveled_up(new_level: int, xp_to_next_level: int)
signal player_current_xp_changed(new_current_xp: int)


func _on_player_leveled_up(new_level: int, xp_to_next_level: int) -> void:
	player_leveled_up.emit(new_level, xp_to_next_level)


func _on_player_current_xp_changed(new_current_xp: int) -> void:
	player_current_xp_changed.emit(new_current_xp)
