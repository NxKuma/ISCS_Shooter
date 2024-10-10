extends Area2D

@export var speed = 500.0
@export var direction = Vector2.ZERO

#func _ready() -> void:
	#if self.get_parent().name == 'Player':
		#direction = Vector2.RIGHT
	#else:
		#direction = Vector2.LEFT
	#print(self.get_parent().name)

func _process(delta: float) -> void:
	translate(direction * speed * delta)


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player': 
		pass
	else:
		pass
