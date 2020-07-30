extends CanvasLayer

func _ready():
	$VBoxContainer/CenterContainer/TextureButton.connect("pressed",self,"reniciar");
	pass

func reniciar():
	get_tree().reload_current_scene()

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		get_tree().reload_current_scene()
