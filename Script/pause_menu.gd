extends CanvasLayer

@onready var score: Label = $Panel/VBoxContainer/Score

func _process(delta: float) -> void:
	if visible:
		score.text = "Score: " + str(Info.get_score())

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("Pause"):
		_toggle_pause()
		
	if event.is_action_pressed("Escape") and get_tree().paused:
		_resume_game()
		get_tree().change_scene_to_file("res://Scene/main_menu.tscn")

func _toggle_pause():
	if get_tree().paused:
		_resume_game()
	else:
		_pause_game()

func _pause_game():
	self.visible = true
	get_tree().paused = true
	# Ensure pause menu still processes input
	self.process_mode = PROCESS_MODE_ALWAYS

func _resume_game():
	self.visible = false
	get_tree().paused = false
