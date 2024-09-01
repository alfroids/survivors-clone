extends Node


func random_point_in_circle(radius: float = 1.0) -> Vector2:
	var R: float = radius * sqrt(randf())
	var T: float = TAU * randf()

	return R * Vector2.RIGHT.rotated(T)
