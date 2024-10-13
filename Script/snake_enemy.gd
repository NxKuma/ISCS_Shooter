extends Area2D

@export var speed = 100.0
@export var direction = Vector2.LEFT
var screen_size

func _ready():
	screen_size = get_viewport_rect().size 

func _process(delta: float) -> void:
	translate(direction * speed * delta)
<<<<<<< Updated upstream

	#deletes the lizard instance when it is sufficiently out of screen
	if global_position < (Vector2.ZERO + Vector2(-300,-300)) or global_position > (screen_size + Vector2(300,300)):
		queue_free() 
=======
	#deletes the snake instance when it is sufficiently out of screen
	if global_position < (Vector2.ZERO + Vector2(-300,-300)) or global_position > (screen_size + Vector2(300,300)):
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("PlayerBullet") and !is_dead:
		area.queue_free()
		health -= 50
		global_position.x += 20
		damaged()
		
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'): 
		body.health -= 30
		health -= 50
		damaged();
		print_debug("hi snake")

func damaged():
	animated_sprite_2d.material.set("shader_parameter/Enabled", true)
	wake.start()
	if health <= 0:
		is_dead = true
		animated_sprite_2d.visible = false
		snake.emitting = true
		set_process(false)
		await get_tree().create_timer(1.0).timeout
		queue_free()


func _on_wake_timeout():
	animated_sprite_2d.material.set("shader_parameter/Enabled", false)
>>>>>>> Stashed changes
