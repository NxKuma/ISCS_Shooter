extends CanvasLayer

@onready var player = $"../Player"
@onready var ui = $"../UI"

func _ready() -> void:
	self.visible = false
	
func _process(float) -> void:
	if ui.bar.scale.x == 500:
		self.visible = true 

func _on_pressed() -> void:
	self.visible = false
	player.get_child(0).visible = true
	player.velocity = Vector2.ZERO
	player.get_child(1).disabled = false
	player.position = Vector2()
