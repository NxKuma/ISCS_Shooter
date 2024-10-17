extends GPUParticles2D

@onready var bomb_sfx: AudioStreamPlayer2D = $BombSFX
@onready var ui:CanvasLayer = $"../UI"

var version: int = 0

func _ready():
	if version == 0:
		amount = 10
		process_material.radial_velocity_min = 20
		process_material.radial_velocity_max = 100
		process_material.scale_min = 1
		process_material.scale_max = 3
	else:
		amount = 40
		process_material.radial_velocity_min = 600
		process_material.radial_velocity_max = 1000
		process_material.scale_min = 30
		process_material.scale_max = 50
		bomb_sfx.play(0.16)

func _on_finished():
	queue_free()


func _on_bomb_area_entered(area):
	if version != 0:
		area.queue_free()
		ui.points += 200
		
