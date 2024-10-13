extends CharacterBody2D

<<<<<<< Updated upstream
=======
@onready var animated_sprite_2d:AnimatedSprite2D = $AnimatedSprite2D
@onready var player:GPUParticles2D = $Player2
@export var speed:int = 400.0
>>>>>>> Stashed changes

@export var speed = 400.0
var screen_size
const PROJECTILE = preload("res://Scene/projectile.tscn")
<<<<<<< Updated upstream
=======
var screen_size:Vector2
var health:float  = 500
var is_dead:bool = false
var hit:bool = false
>>>>>>> Stashed changes

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var movement := Input.get_vector("Left", "Right", "Up", "Down")
	
	if movement:
		velocity = movement * speed
	else:
		velocity = Vector2.ZERO
	
<<<<<<< Updated upstream
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	move_and_slide()

=======
	position += velocity * delta  
	position = position.clamp(Vector2(32,32), Vector2((screen_size.x-160)/2,screen_size.y-32))
	
	move_and_slide()

	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#if collision.get_collider.is_in_group("enemy"):
			#health -= 30
			
#func on_area_entered(area):
	#if area.is_in_group("enemy") and !is_dead:
		#area.health -= 50
		#if health <= 0:
			#is_dead = true
			#animated_sprite_2d.visible = false
			#player.emitting = true
			#set_process(false)
			#queue_free()

func _input(event):
>>>>>>> Stashed changes
	if Input.is_action_just_pressed("Shoot"):
		var new_projectile = PROJECTILE.instantiate()
		new_projectile.direction = Vector2.RIGHT
		new_projectile.global_position = global_position
		add_sibling(new_projectile)
<<<<<<< Updated upstream
		
=======
>>>>>>> Stashed changes
