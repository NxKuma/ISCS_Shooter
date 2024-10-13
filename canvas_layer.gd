extends CanvasLayer

@onready var player = $"../Player"
@onready var ui = $"../UI"

func _ready() -> void:
	self.visible = false
	
func _process(float) -> void:
	if player.health == 0:
		self.visible = true 

func _on_pressed() -> void:
	self.visible = false
	player.animated_sprite_2d.visible = true
	player.health = 500
	player.velocity = Vector2.ZERO
	player.collision_shape_2d.disabled = false
	player.position = Vector2(136,336)
