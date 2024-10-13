extends Area2D

var speed: float = 350.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Vector2.LEFT * speed * delta)


func _on_body_entered(body):
	if body.is_in_group('Player'): 
		body.bombs += 1
		queue_free()
