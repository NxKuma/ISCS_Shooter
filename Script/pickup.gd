extends Area2D

@onready var pickup_sfx: AudioStreamPlayer2D = $PickupSFX
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var speed: float = 350.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Vector2.LEFT * speed * delta)


func _on_body_entered(body):
	if body.is_in_group('Player'): 
		pickup_sfx.play(0.11)
		sprite.visible = false
		await get_tree().create_timer(0.7).timeout
		body.bombs += 1
		queue_free()
