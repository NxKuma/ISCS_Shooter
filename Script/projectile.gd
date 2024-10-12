extends Area2D

@export var speed:float = 500.0
@export var version:int = 0
@export var direction:Vector2 = Vector2.ZERO
@onready var animated_sprite_2d:AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	if version == 0:
		animated_sprite_2d.play("Player")
	else:
		animated_sprite_2d.play("Enemy")
		animated_sprite_2d.flip_h = true
	
		

func _process(delta: float) -> void:
	translate(direction * speed * delta)

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player': 
		pass
	else:
		pass

func _on_life_timeout() -> void:
	queue_free()
