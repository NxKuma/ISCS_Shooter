extends Area2D

@export var speed:float = 100.0
@export var direction:Vector2 = Vector2.LEFT
@onready var snake:GPUParticles2D = $Snake2
@onready var animated_sprite_2d:AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D

const PROJECTILE = preload("res://Scene/particle_effect.tscn")

var screen_size:Vector2
var is_hit:bool = false

func _ready():
	screen_size = get_viewport_rect().size 

func _process(delta: float) -> void:
	translate(direction * speed * delta)

	#deletes the lizard instance when it is sufficiently out of screen
	if global_position < (Vector2.ZERO + Vector2(-300,-300)) or global_position > (screen_size + Vector2(300,300)):
		queue_free()


func _on_area_entered(area):
	if area.is_in_group("PlayerBullet") and !is_hit:
		is_hit = true
		area.queue_free()
		animated_sprite_2d.visible = false
		snake.emitting = true
		set_process(false)
		await get_tree().create_timer(1.0).timeout
		queue_free()
		
