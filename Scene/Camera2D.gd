extends Camera2D

@export var randomStrength: float = 2.0
@export var shakeFade: float = 10.0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

func apply_shake(strenght: float):
	shake_strength = strenght

func _process(delta):
	if Input.is_action_just_pressed("Shoot"):
		apply_shake(randomStrength)
	
	if shake_strength > 0:
		shake_strength = lerp(shake_strength, 0.0, shakeFade * delta)
		offset = randomOffset()

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
