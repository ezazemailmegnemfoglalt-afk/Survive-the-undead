extends CharacterBody2D

@export var max_health: int = 1000.0
@export var speed: float = 200.0
@export var damage: int = 10

var health: int
@onready var anim: AnimatedSprite2D = $CharacterBody2D

func _ready():
	health = max_health

func _physics_process(delta):
	_handle_movement()
	_check_death()

func _handle_movement():
	var dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if dir != Vector2.ZERO:
		velocity = dir.normalized() * speed
		move_and_slide()
		anim.play("walk")
		if dir.x < 0: anim.flip_h = true
		elif dir.x > 0: anim.flip_h = false
	else:
		velocity = Vector2.ZERO
		move_and_slide()
		anim.play("idle")


func take_damage(amount: int):
	health -= amount
	health = max(health, 0)  
	print("Sebzés:", amount, " | Jelenlegi élet:", health)

func _on_hitbox_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		print("you have hurted the eney" )

func heal(amount: int):
	health += amount
	health = min(health, max_health)  
	print("Gyógyítás:", amount, " | Jelenlegi élet:", health)

func _check_death():
	if health <= 0:
		die()

func die():
	print("A karakter meghalt!")
	anim.play("dead") 
	queue_free()
