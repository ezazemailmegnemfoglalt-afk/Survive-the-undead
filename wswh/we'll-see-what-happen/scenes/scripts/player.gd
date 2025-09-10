extends CharacterBody2D

@export var speed: float = 200.0
@export var max_health: int = 100
@export var damage: int = 25
@onready var hurtbox: Area2D = $Hurtbox

var health: int
@onready var anim: AnimatedSprite2D = $CharacterBody2D

func _ready():
	health = max_health
	add_to_group("players")


func _physics_process(delta):
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = dir * speed
	move_and_slide()

	if dir != Vector2.ZERO:
		anim.play("walk")
		if dir.x < 0: anim.flip_h = true
		elif dir.x > 0: anim.flip_h = false


# kap sebzést
func take_damage(amount: int) -> void:
	health -= amount
	print("Player kapott:", amount, "| élet:", health)
	if health <= 0:
		die()

func die():
	queue_free()

func _on_Hitbox_body_entered(body: Node):
	if body.is_in_group("hurtbox"):
		var parent = body.get_parent()
		if parent.is_in_group("enemies"):
			if parent.has_method("take_damage"):
				parent.take_damage(damage)
				print("Player sebzett:", damage)

func _on_Hurtbox_body_entered(body: Node):
	if body.is_in_group("hitbox"):
		var parent = body.get_parent()
		if parent.has_method("deal_damage"):
			parent.deal_damage(self)

# egérkattintás -> sebzés a hitbox által
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		for body in $Hitbox.get_overlapping_bodies():
			if body.is_in_group("enemies"):
				body.take_damage(damage)
				print("Player sebzett:", damage)
