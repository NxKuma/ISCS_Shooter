extends Area2D

@export var speed = 100.0
@export var direction = Vector2.LEFT
var screen_size

func _ready():
	screen_size = get_viewport_rect().size 

func _process(delta: float) -> void:
	translate(direction * speed * delta)

	#deletes the lizard instance when it is sufficiently out of screen
	if global_position < (Vector2.ZERO + Vector2(-300,-300)) or global_position > (screen_size + Vector2(300,300)):
		queue_free()
