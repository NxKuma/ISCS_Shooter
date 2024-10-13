extends Area2D

@export var speed:float = 500.0
@export var version:int = 0
@export var direction:Vector2 = Vector2.ZERO

@onready var animated_sprite_2d:AnimatedSprite2D = $AnimatedSprite2D
@onready var camera_2d:Camera2D = $"../Camera2D"

const GPU = preload("res://Scene/Bullet_shatter.tscn")

func _ready():
	if version == 0:
		animated_sprite_2d.play("Player")
		add_to_group("PlayerBullet")
		speed = 800
	else:
		animated_sprite_2d.play("Enemy")
		animated_sprite_2d.flip_h = true
		add_to_group("EnemyBullet")

func _process(delta: float) -> void:
	translate(direction * speed * delta)

func _on_body_entered(body: Node2D) -> void:
	if body.name.contains('Player') and version !=0 : 
		#Edit Player Values
		body.health -= 10
		body.animated_sprite_2d.material.set("shader_parameter/Enabled", true)
		body.wake.start()
		body.set_process(false)
		#Apply Camera Shake
		camera_2d.apply_shake(8.0)
		#Create Particle Effects
		var particle = GPU.instantiate()
		particle.emitting = true
		particle.position = position
		add_sibling(particle)
		#Delete Bullet
		queue_free()

func _on_life_timeout() -> void:
	queue_free()
