extends Node

var score: int = 0
signal score_changed(new_score: int)

func add_point(amount: int = 1):
	score += amount
	emit_signal("score_changed", score)

func reset():
	score = 0
	emit_signal("score_changed", score)
