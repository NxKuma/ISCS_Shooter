extends CharacterBody2D

@onready var animated_sprite_2d:AnimatedSprite2D = $AnimatedSprite2D
@export var speed:int = 400.0
@onready var wake:Timer = $Wake
@onready var death_screen:CanvasLayer = $"../DeathScreen"
@onready var collision_shape_2d:CollisionShape2D = $CollisionShape2D
@onready var glass:GPUParticles2D = $Glass
@onready var death:GPUParticles2D = $Player
@onready var bgm: AudioStreamPlayer2D = $"../BGM"
@onready var death_sfx: AudioStreamPlayer2D = $DeathSFX
@onready var pew_sfx: AudioStreamPlayer2D = $PewSFX

const PROJECTILE = preload("res://Scene/projectile.tscn")
var screen_size:Vector2
var health:float = 500
var bombs:int = 0
var hit:bool = false
var can_bomb:bool = false

func _ready():
	screen_size = get_viewport_rect().size
	bgm.play()
 
func _process(delta: float) -> void:
	if Input.is_action_pressed("Shoot") or Input.is_action_pressed("Bomb"):
		animated_sprite_2d.play("Shoot")
		var new_projectile = PROJECTILE.instantiate()
		if Input.is_action_just_pressed("Bomb") and can_bomb:
			pew_sfx.play(0.21)
			new_projectile.version = 3
			bombs = 0
		else:
			new_projectile.version = 0
		new_projectile.direction = Vector2.RIGHT
		new_projectile.global_position = Vector2(global_position.x + 42, global_position.y + 5)
		add_sibling(new_projectile)
	
	
	var movement := Input.get_vector("Left", "Right", "Up", "Down")
	if movement:
		velocity = movement * speed
	else:
		velocity = Vector2.ZERO
	position += velocity * delta 
	position = position.clamp(Vector2(32,32), Vector2((screen_size.x-160)/2,screen_size.y-32))
	move_and_slide()
	
	if health <= 0:
		death_sfx.play(0.02)
		death_screen.visible = true
		bombs = 0
		animated_sprite_2d.visible = false
		collision_shape_2d.disabled = true
		glass.emitting = true
		death.emitting = true
		set_process(false)

#func _input(event):
	#if Input.is_action_pressed("Shoot") or Input.is_action_pressed("Bomb"):
		#animated_sprite_2d.play("Shoot")
		#var new_projectile = PROJECTILE.instantiate()
		#if Input.is_action_just_pressed("Bomb") and can_bomb:
			#pew_sfx.play(0.21)
			#new_projectile.version = 3
			#bombs = 0
		#else:
			#new_projectile.version = 0
		#new_projectile.direction = Vector2.RIGHT
		#new_projectile.global_position = Vector2(global_position.x + 42, global_position.y + 5)
		#add_sibling(new_projectile)


func _on_wake_timeout():
	animated_sprite_2d.material.set("shader_parameter/Enabled", false)
	self.set_process(true)
