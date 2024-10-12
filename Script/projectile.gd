extends Area2D

@export var speed:float = 500.0
@export var version:int = 0
@export var direction:Vector2 = Vector2.ZERO
@onready var animated_sprite_2d:AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	if version == 0:
		animated_sprite_2d.play("Player")
		add_to_group("PlayerBullet")
	else:
		animated_sprite_2d.play("Enemy")
		animated_sprite_2d.flip_h = true
		add_to_group("EnemyBullet")

func _process(delta: float) -> void:
	translate(direction * speed * delta)

func _on_body_entered(body: Node2D) -> void:
	if body.name.contains('Player') and version !=0 : 
		#body.hit = true
		body.health -= 10

func _on_life_timeout() -> void:
	queue_free()

