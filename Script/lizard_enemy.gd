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
<<<<<<< Updated upstream
=======


func _on_area_entered(area):
	if area.is_in_group("PlayerBullet") and !is_dead:
		area.queue_free()
		is_hit = true
		global_position.x += 20
		health -= 30
		damaged()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'): 
		body.health -= 10
		health -= 50
		damaged()
		print_debug("snake")


func damaged():
	animated_sprite_2d.material.set("shader_parameter/Enabled", true)
	wake.start()
	if health <= 0:
		is_dead = true
		animated_sprite_2d.visible = false
		collision_shape_2d.disabled = true
		particle.emitting = true
		set_process(false)
		await get_tree().create_timer(1.0).timeout
		queue_free()

func _on_wake_timeout():
	animated_sprite_2d.material.set("shader_parameter/Enabled", false)


func _on_reload_timeout():
	if !is_dead:
		shoot()
>>>>>>> Stashed changes
