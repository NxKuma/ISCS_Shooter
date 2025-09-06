extends Control

@export var entry_scene: PackedScene
@onready var leader_board: VBoxContainer = $PanelContainer/LeaderBoard

func _ready():
# connect to the global signal
	DreamLo.connect("scores_fetched", Callable(self, "_on_scores_fetched"))
	# Fetch scores at start
	DreamLo.fetch_scores(10)

func _on_scores_fetched(entries: Array):
	_clear_leaderboard()
	for x in range(0, 10):
		var instance = entry_scene.instantiate()
		if instance.has_method("setup"):
			if x < entries.size():
				instance.setup(entries[x].name, entries[x].score)
			else:
				instance.setup("XXXXX", 000000)
		leader_board.add_child(instance)
		
	#for e in entries:
		#var instance = entry_scene.instantiate()
		#if instance.has_method("setup"):
			#instance.setup(e.name, e.score)
		#leader_board.add_child(instance)

func _clear_leaderboard():
	for child in leader_board.get_children():
		if child.name != "Title":
			child.queue_free()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Escape"):
		get_tree().change_scene_to_file("res://Scene/main_menu.tscn")
