extends CharacterBody2D


@export var speed = 500.0
var screen_size
const PROJECTILE = preload("res://Scene/projectile.tscn")

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

	if Input.is_action_just_pressed("Shoot"):
		var new_projectile = PROJECTILE.instantiate()
		new_projectile.direction = Vector2.RIGHT
		new_projectile.global_position = global_position
		add_sibling(new_projectile)
