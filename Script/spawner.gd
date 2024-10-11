extends Node2D

const SNAKE_ENEMY = preload("res://Scene/snake_enemy.tscn")
const LIZARD_ENEMY = preload("res://Scene/lizard_enemy.tscn")



func _on_timer_timeout() -> void:
	var snake = SNAKE_ENEMY.instantiate()
	snake.position = position
	print(snake)
	get_parent().get_node("SnakeEnemy").add_child(snake)
