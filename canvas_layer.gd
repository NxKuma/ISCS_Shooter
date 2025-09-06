extends CanvasLayer

@onready var player:CharacterBody2D = $"../Player"
@onready var ui:CanvasLayer = $"../UI"
@onready var spawner = $"../Spawner"
@onready var area_2d:Area2D = $Area2D
@onready var score: RichTextLabel = $VBoxContainer/HSplitContainer/Score
@onready var text_edit: LineEdit = $VBoxContainer/HSplitContainer/TextEdit

func _ready() -> void:
	self.visible = false
	area_2d.get_child(0).disabled = true
	
func _process(float) -> void:
	if player.health <= 0:
		self.visible = true 
		spawner.visible = false
		score.text = "[font_size=60][center][font=./Fonts/04B11-xrr.TTF]" + str(ui.points)
		area_2d.get_child(0).disabled = false

func _on_pressed() -> void:
	if text_edit.text.length() > 1:
		Info.set_player_name(text_edit.text)
		DreamLo.submit_score(Info.get_player_name(),Info.get_score())
		get_tree().change_scene_to_file("res://Scene/leaderboard.tscn")
		#self.visible = false
		#spawner.visible = true
		#area_2d.get_child(0).disabled = true
		#ui.points = 0
		#player.animated_sprite_2d.visible = true
		#player.health = 500
		#player.set_process(true)
		#player.velocity = Vector2.ZERO
		#player.collision_shape_2d.disabled = false
		#player.position = Vector2(136,336)


func _on_area_2d_area_entered(area):
	area.queue_free()
