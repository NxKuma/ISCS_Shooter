extends CharacterBody2D


@export var speed = 500.0


func _process(delta: float) -> void:
	var movement := Input.get_vector("Left", "Right", "Up", "Down")
	
	if movement:
		velocity = movement * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
