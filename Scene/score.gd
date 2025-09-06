extends Panel

func setup(player_name: String, score: int):
	$HSplitContainer/Name.text = player_name
	$HSplitContainer/Score.text = str(score)
