extends StaticBody2D
func _ready():
	global_position.x = 620;
	global_position.y = 210;
	pass

func _physics_process(delta):
	global_position.x -= FileVariavles.velosida * delta;
	if global_position.x <= -20:
		queue_free()
