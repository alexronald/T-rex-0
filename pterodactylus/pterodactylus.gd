extends StaticBody2D
func _ready():
	global_position.x = 630;
	var posY = 210;
	randomize()
	var ran = stepify(rand_range(0,1),0.01);
	if(ran > 0 && ran <= 0.40):
		posY = 150;
	elif(ran > 0.40 && ran <= 0.80):
		posY = 190;
	elif(ran > 0.80):
		posY = 210;
	global_position.y = posY #150,210,190
	pass

func _physics_process(delta):
	global_position.x -= FileVariavles.velosida * delta +2;
	if global_position.x <= -20:
		queue_free()
