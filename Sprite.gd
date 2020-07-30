extends Sprite
var t = load("res://recursos/estrellas/estrellas1.png")
func _ready():
	get_parent().connect("desapareserestellas",self,"desapareserestellas");
	randomize()
	var rando = randi()%3+1;
	match(rando):
		1:
			t = load("res://recursos/estrellas/estrellas2.png")
		2:
			t = load("res://recursos/estrellas/estrellas.png")
	print(rando);
	texture = t;
	global_position.x = randi()%610+1;
	global_position.y = randi()%150+50;
	pass

func _process(delta):
	global_position.x -= (FileVariavles.velosida/2) * delta;
	if global_position.x <= -20:
		global_position.x = 620;
		global_position.y = randi()%150+50;

func desapareserestellas():
	queue_free()
