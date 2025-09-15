class_name EnemyHurtBox
extends Area2D

@export var health: Health
signal received_damage(damage: int)

func _ready():
	connect("area_entered", _on_area_entered)
	monitoring = true

func _on_area_entered(area: Area2D):
	if area is PlayerHitBox and area.monitoring:
		health.set_health(health.health - area.damage)
		received_damage.emit(area.damage)
		print("Enemy sebződött: %d" % area.damage)
