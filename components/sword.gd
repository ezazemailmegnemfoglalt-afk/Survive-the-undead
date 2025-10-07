class_name Sword
extends Area2D

@onready var timer = $Timer
@onready var anim = $AnimatedSprite2D

var triggered = false
var lvl1 = false
var lvl4 = false

func _ready() -> void:
	if get_tree().get_first_node_in_group("lvl1"):
		anim.play("defagrave")
		timer.start()
		timer.timeout.connect(swordcominganim)
		lvl1 = true
	elif  get_tree().get_first_node_in_group("lvl4"):
		anim.play("default")
		lvl4 = true

func swordcominganim():
	anim.play("incoming")

func _on_area_entered(area: Area2D):
	if lvl1 == true:
		if area is PlayerHitBox and triggered == false:
			area.damage += 10
			print("Damage +10!")

		# Notify UIManager about the damage change
			var game_manager = get_node("/root/GameManager")
			if game_manager:
				game_manager.emit_signal("player_damage_changed", area.damage)
			triggered = true
			await get_tree().create_timer(0.5).timeout
			anim.play("notincoming")
		if area is PlayerHitBox and triggered == true:
			pass
	elif lvl4 == true:
		area.damage += 10
		print("Damage +10!")
		queue_free()
