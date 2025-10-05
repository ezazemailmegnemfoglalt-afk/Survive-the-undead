extends CharacterBody2D

@export var speed: float = 200.0
@export var sped: float = 200.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: PlayerHitBox = $PlayerHitBox
@onready var health: Health = $Health
@onready var end_menu_bad = $Camera2D2/EndMenuBad

var sword = false

func _ready():
	# Connect to GameManager for death (optional - if you need player-specific death logic)
	var game_manager = get_node("/root/GameManager")
	if game_manager:
		game_manager.player_died.connect(_on_player_died)

func _on_player_died():
	# Disable player controls and physics
	set_process_input(false)
	set_physics_process(false)
	
	# Disable collision
	if has_node("CollisionShape2D"):
		$CollisionShape2D.set_deferred("disabled", true)
	
	# Disable hitboxes/hurtboxes
	for child in get_children():
		if child is Area2D:
			child.monitoring = false
			child.monitorable = false
	
	print("Player: Disabled due to death")

func _physics_process(delta):
	var dire = Input.get_vector("moveleft", "moveright", "moveup", "movedown")
	velocity = dire.normalized() * speed if dire != Vector2.ZERO else Vector2.ZERO
	move_and_slide()

	if dire  != Vector2.ZERO  :
		if sword == false:
			anim.play("walk")
		else:
			anim.play("sword")
		anim.flip_h = dire.x < 0
	else:
		if sword == false:
			anim.play("idle")
		else:
			anim.play("idelsword")
	if Input.is_action_just_pressed("attack"):
		_apply_attack()

func _apply_attack():
	anim.play("attack")
	var overlapping = hitbox.get_overlapping_areas()
	for area in overlapping:
		if area is EnemyHurtBox:
			# Damage the enemy through its Health component
			if area.health:
				area.health.set_health(area.health.health - hitbox.damage)
				print("Enemy sebződött újra kattintásra - Damage: ", hitbox.damage)


func _on_health_depleted():
	queue_free()
	var end_menu = get_tree().root.find_child("EndMenuBad", true, false)
	if end_menu:
		end_menu.visible = true


func _on_player_hit_box_area_entered(area: Area2D) -> void:
	if area is Sword:
		sword = true
