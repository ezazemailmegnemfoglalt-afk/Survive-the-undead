extends Node


var score: int = 0
signal score_changed(new_score: int)

func add_point(amount: int = 1):
	score += amount
	score_changed.emit(score)
