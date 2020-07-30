extends Sprite
func _ready():
	global_position.x = 600;
	global_position.y = randi()%120+20;
	pass

func _process(delta):
	global_position.x -= (FileVariavles.velosida/2) * delta;
	if global_position.x <= -20:
		queue_free()

