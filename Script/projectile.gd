extends Area2D

@export var speed = 500.0
@export var direction = Vector2.ZERO


func _process(delta: float) -> void:
	translate(direction * speed * delta)


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player': 
		pass
	else:
		pass


func _on_life_timeout() -> void:
	queue_free()
