extends Node2D

@onready var start: Button = $Panel/VBoxContainer/HSplitContainer/Start
@onready var exit: Button = $Panel/VBoxContainer/HSplitContainer/Exit
@onready var leader: Button = $Panel/VBoxContainer/Leader




func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/main.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_leader_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/leaderboard.tscn")
