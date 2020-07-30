extends Node
var velosida = 300;
var fileSave = "user://savedata.sev";
func _ready():
	var file =   File.new();
	if(!file.file_exists(fileSave)):
		guardar(0);
	pass

func guardar(maxScore):
	var file = File.new();
	var error = file.open_encrypted_with_pass(fileSave,File.WRITE,"score");
	print(error)
	file.store_64(maxScore);
	file.close();
	pass

func leer ():
	var score = 0;
	var file = File.new();
	if (file.file_exists(fileSave)):
		var error = file.open_encrypted_with_pass(fileSave,File.READ,"score");
		score = file.get_64();
		file.close();
	return score;
	pass
