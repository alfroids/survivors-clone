extends Control

@onready var level_progress_bar: ProgressBar = %LevelProgressBar as ProgressBar
@onready var level_label: Label = %LevelLabel as Label
@onready var main: Control = %Main as Control


func _ready() -> void:
	SignalBus.player_leveled_up.connect(_on_player_leveled_up)
	SignalBus.player_current_xp_changed.connect(_on_current_xp_changed)
	main.visible = false


func _on_player_leveled_up(new_level: int, xp_to_next_level: int) -> void:
	level_progress_bar.max_value = xp_to_next_level
	level_progress_bar.value = 0
	level_label.text = "LVL " + str(new_level)
	if new_level > 1:
		main.visible = true
		get_tree().paused = true


func _on_current_xp_changed(new_current_xp: int) -> void:
	level_progress_bar.value = new_current_xp


func _on_button_pressed() -> void:
	main.visible = false
	get_tree().paused = false
