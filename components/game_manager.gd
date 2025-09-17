var score: int = 0

func add_score(points: int = 1) -> void:
	score += points
	print("Pontszám:", score)

func reset_score() -> void:
	score = 0
