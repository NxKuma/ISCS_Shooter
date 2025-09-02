extends Node

var player_name: String
var player_score: int
var is_playing: bool

func set_player_name(name: String) -> void:
	player_name = name
	
func get_player_name() -> String:
	return player_name

func set_score(score: int) -> void:
	player_score = score

func get_score() -> int:
	return player_score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
