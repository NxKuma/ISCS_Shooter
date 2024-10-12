extends CharacterBody2D

@onready var animated_sprite_2d:AnimatedSprite2D = $AnimatedSprite2D
@export var speed:int = 400.0

const PROJECTILE = preload("res://Scene/projectile.tscn")
var screen_size:Vector2

func _ready():
	screen_size = get_viewport_rect().size
 
func _process(delta: float) -> void:
	var movement := Input.get_vector("Left", "Right", "Up", "Down")
	
	if movement:
		velocity = movement * speed
	else:
		velocity = Vector2.ZERO
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	move_and_slide()


func _input(event):
	if Input.is_action_just_pressed("Shoot"):
		animated_sprite_2d.play("Shoot")
		var new_projectile = PROJECTILE.instantiate()
		new_projectile.version = 0
		new_projectile.direction = Vector2.RIGHT
		new_projectile.global_position = Vector2(global_position.x + 42, global_position.y + 5)
		add_sibling(new_projectile)
		
