extends CanvasLayer
@onready var bar:Sprite2D = $Bar
@onready var bomb:Sprite2D = $BombBar
@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bar.scale.x = player.health/100
	if player.bombs <= 5:
		bomb.scale.x = player.bombs 
		if player.bombs == 5:
			player.can_bomb = true
		else:
			player.can_bomb = false
