extends CharacterBody2D

@export var speed: float = 200.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	print("Node osztály:", get_class())  # debug

func _physics_process(delta):
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if dir != Vector2.ZERO:
		dir = dir.normalized()

		velocity = dir * speed

		if abs(dir.x) > 0.0:
			anim.play("walk")
			anim.flip_h = dir.x < 0
		elif dir.y < 0:
			anim.play("walk")
		else:
			anim.play("walk")
	else:
		velocity = Vector2.ZERO
		anim.play("idle")
	move_and_slide()

func _on_health_health_depleted() -> void:
	queue_free()
	print("player megdöglődött a gecibe")
	
