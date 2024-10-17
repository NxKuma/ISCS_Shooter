extends Node2D

const SNAKE_ENEMY = preload("res://Scene/snake_enemy.tscn")
const LIZARD_ENEMY = preload("res://Scene/lizard_enemy.tscn")

@onready var timer:Timer = $Timer

func _on_timer_timeout() -> void:
	if visible == true:
		var random_height:float = randf_range(-200,200)
		var random_enemy:int = randi_range(0,1)
		var enemy
		match random_enemy:
			0: enemy = SNAKE_ENEMY.instantiate()
			1: enemy = LIZARD_ENEMY.instantiate()
		add_sibling(enemy)
		enemy.position = Vector2(position.x ,position.y + random_height)
		timer.wait_time = randi_range(1,2)
	
