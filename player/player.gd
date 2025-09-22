extends CharacterBody2D

@export var speed: float = 200.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: PlayerHitBox = $PlayerHitBox
@onready var health: Health = $Health
@onready var health_label: Label = $HealthLabel

func _ready():
	add_to_group("players")
	health.health_depleted.connect(_on_health_depleted)
	health.health_changed.connect(_update_health_label)
	_update_health_label()

func _physics_process(delta):
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = dir.normalized() * speed if dir != Vector2.ZERO else Vector2.ZERO
	move_and_slide()

	if dir != Vector2.ZERO:
		anim.play("walk")
		anim.flip_h = dir.x < 0
	else:
		anim.play("idle")
	if Input.is_action_just_pressed("attack"):
		_apply_attack()

func _apply_attack():
	anim.play("attack")
	var overlapping = hitbox.get_overlapping_areas()
	for area in overlapping:
		if area is EnemyHurtBox:
			var health = area.health
			if health:
				health.set_health(health.health - hitbox.damage)
				print("Enemy sebződött újra kattintásra")


func _on_health_depleted():
	queue_free()
	var end_menu_scene = load("res://components/EndMenuBad.tscn")
	var end_menu = end_menu_scene.instantiate()
	get_tree().current_scene.add_child(end_menu)
	end_menu.visible = true


func _update_health_label():
	health_label.text = "HP: %d" % health.health
