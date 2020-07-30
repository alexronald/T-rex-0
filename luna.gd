extends Node2D

func _ready():
	get_parent().connect("desapareserluana",self,"desapareserluana");
	global_position.x = 620;
	global_position.y = 150;
	pass

func _process(delta):
	global_position.x -= (FileVariavles.velosida/2) * delta;
	
	if global_position.x <= -20:
		global_position.x = 620;
		global_position.y = 150;

func desapareserluana():
	queue_free();
