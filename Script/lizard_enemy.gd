extends Area2D

@export var speed:float = 100.0
@export var direction:Vector2 = Vector2.LEFT

@onready var animated_sprite_2d:AnimatedSprite2D = $AnimatedSprite2D
@onready var timer:Timer = $Timer
@onready var particle:GPUParticles2D = $Particle2
@onready var collision_shape_2d:CollisionShape2D = $CollisionShape2D

var shoot_speed:int = 1
var screen_size:Vector2
var is_hit:bool = false
const PROJECTILE = preload("res://Scene/projectile.tscn")

func _ready():
	timer.wait_time = shoot_speed
	screen_size = get_viewport_rect().size 

func _process(delta: float) -> void:
	translate(direction * speed * delta)
	global_position.y += sin(global_position.x * delta) * 7

	#deletes the lizard instance when it is sufficiently out of screen
	if global_position < (Vector2.ZERO + Vector2(-300,-300)) or global_position > (screen_size + Vector2(300,300)):
		queue_free() 


func shoot():
	var new_projectile = PROJECTILE.instantiate()
	timer.start()
	animated_sprite_2d.play("Shoot")
	new_projectile.version = 2
	new_projectile.direction = Vector2.LEFT
	new_projectile.global_position = Vector2(global_position.x - 42, global_position.y + 10)
	add_sibling(new_projectile)


func _on_timer_timeout():
	if !is_hit:
		shoot()


func _on_area_entered(area):
	if area.is_in_group("PlayerBullet") and !is_hit:
		is_hit = true
		area.queue_free()
		animated_sprite_2d.visible = false
		collision_shape_2d.disabled = true
		particle.emitting = true
		set_process(false)
		await get_tree().create_timer(1.0).timeout
		queue_free()
		
