extends Area2D

@export var speed = 100.0
@export var direction = Vector2.LEFT
var shootspeed = 50
const PROJECTILE = preload("res://Scene/projectile.tscn")

func _process(delta: float) -> void:
	translate(direction * speed * delta)
	global_position.y += sin(position.x * delta) * 6
	
	if Engine.get_process_frames() % shootspeed == 0:
		shoot()


func shoot():
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.direction = Vector2.LEFT
	new_projectile.global_position = global_position
	add_sibling(new_projectile)
