extends Area2D

@export var speed:float = 100.0
@export var direction:Vector2 = Vector2.LEFT

@onready var animated_sprite_2d:AnimatedSprite2D = $AnimatedSprite2D
@onready var timer:Timer = $Reload
@onready var particle:GPUParticles2D = $Particle2
@onready var collision_shape_2d:CollisionShape2D = $CollisionShape2D
@onready var wake:Timer = $Wake
@onready var camera_2d:Camera2D = $"../Camera2D"

var shoot_speed:int = 1
var screen_size:Vector2
var is_hit:bool = false
var is_dead:bool = false
var health:int = 100

const PROJECTILE = preload("res://Scene/projectile.tscn")
const SHUTTER = preload("res://Scene/Bullet_shatter.tscn")
const PICKUP = preload("res://Scene/pickup.tscn")

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


func _on_area_entered(area):
	if area.is_in_group("PlayerBullet") and !is_dead:
		area.queue_free()
		is_hit = true
		global_position.x += 20
		health -= 30
		var broke = SHUTTER.instantiate()
		if area.version == 3:
			broke.version = 1
			camera_2d.apply_shake(20.0)
		else:
			broke.version = 0
		broke.position = area.position
		broke.emitting = true
		add_sibling(broke)
		damaged()

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.is_in_group('Player'): 
		#Edit Player Values
		body.health -= 10
		body.animated_sprite_2d.material.set("shader_parameter/Enabled", true)
		body.wake.start()
		body.set_process(false)
		
		camera_2d.apply_shake(8.0)
		
		health -= 50
		damaged()
		print_debug("snake")


func damaged():
	animated_sprite_2d.material.set("shader_parameter/Enabled", true)
	wake.start()
	if health <= 0:
		is_dead = true
		summon()
		animated_sprite_2d.visible = false
		collision_shape_2d.disabled = true
		particle.emitting = true
		set_process(false)
		await get_tree().create_timer(1.0).timeout
		queue_free()

func summon():
	var willbomb:int = randi_range(1,20)
	if willbomb == 8:
		var pickup = PICKUP.instantiate()
		pickup.global_position = global_position
		add_sibling(pickup)

func _on_wake_timeout():
	animated_sprite_2d.material.set("shader_parameter/Enabled", false)


func _on_reload_timeout():
	if !is_dead:
		shoot()
