extends CanvasLayer

@onready var player:CharacterBody2D = $"../Player"
@onready var ui:CanvasLayer = $"../UI"
@onready var spawner = $"../Spawner"
@onready var area_2d:Area2D = $Area2D
@onready var score:RichTextLabel = $Score

func _ready() -> void:
	self.visible = false
	area_2d.get_child(0).disabled = true
	
func _process(float) -> void:
	if player.health <= 0:
		self.visible = true 
		spawner.visible = false
		score.text = "[font_size=60][center][font=./Fonts/04B11-xrr.TTF]Score: " + str(ui.points)
		area_2d.get_child(0).disabled = false

func _on_pressed() -> void:
	self.visible = false
	spawner.visible = true
	area_2d.get_child(0).disabled = true
	ui.points = 0
	player.animated_sprite_2d.visible = true
	player.health = 500
	player.set_process(true)
	player.velocity = Vector2.ZERO
	player.collision_shape_2d.disabled = false
	player.position = Vector2(136,336)


func _on_area_2d_area_entered(area):
	area.queue_free()
