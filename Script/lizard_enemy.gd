extends Area2D

@export var speed = 100.0
@export var direction = Vector2.LEFT
var shoot_speed = 50
var screen_size
const PROJECTILE = preload("res://Scene/projectile.tscn")

func _ready():
	screen_size = get_viewport_rect().size 

func _process(delta: float) -> void:
	translate(direction * speed * delta)
	global_position.y += sin(global_position.x * delta) * 6
	
	if Engine.get_process_frames() % shoot_speed == 0:
		shoot()
	
	#deletes the lizard instance when it is sufficiently out of screen
	if global_position < (Vector2.ZERO + Vector2(-300,-300)) or global_position > (screen_size + Vector2(300,300)):
		queue_free() 


func shoot():
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.direction = Vector2.LEFT
	new_projectile.global_position = global_position
	add_sibling(new_projectile)
