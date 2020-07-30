extends Node2D
export (PackedScene) var captus = load("res://captus/captus1.tscn");
export(PackedScene) var nubes = load("res://nube/nube.tscn");
export(PackedScene) var luna = load("res://noche/luna.tscn");
export(PackedScene) var estrallas = load("res://noche/strellas.tscn");
#export(PackedScene) var pterodactylus = load("res://pterodactylus/pterodactylus.tscn");
export(PackedScene) var gameOver;

var escor = 0;
var limiteScore = 100;
var limiteStado = 700;
var limitVel = 20;
var empezar = false
var maxtiempo = 2;
var minTiempo = 0.7;
var cantStrellas = 0;
var deDia = true;

#señales
signal desapareserluana();
signal desaparesernubes();
signal desapareserestellas();
func _ready():
	$nuevoScore.text = "HI"+(str(FileVariavles.leer()).pad_zeros(5));
	if(get_tree().paused):
		FileVariavles.velosida = 250;
		empezarjuego()
	get_tree().paused=false
	pass

func _process(delta):
	if(Input.is_action_just_pressed("ui_up") && !empezar):
		empezarjuego()
	if empezar:
		$background.scroll_offset.x -= FileVariavles.velosida*delta
	if(escor == limiteStado):
		deDia = !deDia
		if !deDia:
			add_child(luna.instance())
			$background/ColorRect.color= "#000";
		else:
			cantStrellas = 0;
			emit_signal("desapareserluana");
			emit_signal("desapareserestellas");
			$background/ColorRect.color= "#fff";
		limiteStado +=700;
	if(escor == limitVel):
		limitVel += 20;
		FileVariavles.velosida += 5
		maxtiempo -= 0.02
		maxtiempo = clamp(maxtiempo,1.2,2)
		FileVariavles.velosida = clamp(FileVariavles.velosida,300,700)
	
	if(escor == limiteScore):
		limiteScore += 100;
		$limite.playing = true;
	
	$score.text = str(escor).pad_zeros(5)
	pass
func finJuego():
	if FileVariavles.leer() < escor:
		FileVariavles.guardar(escor)
		$nuevoScore.text = "HI"+(str(FileVariavles.leer()).pad_zeros(5));
	add_child(gameOver.instance());
	get_tree().paused = true;

func empezarjuego():
	empezar = true
	#$palyer/Sprite.animation = "idle";
	
func getEnpezando():
	return empezar;

func _on_Timer_timeout():
	if empezar:
		instanciar()
		var tiempo = rand_range(minTiempo,maxtiempo);
		$Timer.wait_time = tiempo;
		
	pass
	
func generar():
	var valor;
	randomize()
	var ran = stepify(rand_range(0,1),0.01);
	if(ran > 0 && ran <= 0.16):
		valor = 1;
	elif(ran > 0.16 && ran <= 0.32):
		valor = 2;
	elif(ran > 0.32 && ran <= 0.48):
		valor = prob(3);
	elif(ran > 0.48 && ran <= 0.68):
		valor = 4;
	elif(ran > 0.68 && ran <= 0.88):
		valor = prob(5);
	elif(ran > 0.88):
		valor = prob(6);
	return valor;

func instanciar():
	var valor = generar()
	match(valor):
		1:
			captus = load("res://captus/captus3.tscn");
		2:
			captus = load("res://captus/captus4.tscn");
		3:
			captus = load("res://captus/captus5.tscn");
		4:
			captus = load("res://captus/captus.tscn");
		5:
			captus = load("res://captus/captus2.tscn");
		6:
			captus = load("res://captus/captus1.tscn");
		7:
			captus = load("res://pterodactylus/pterodactylus.tscn");
	
	if !deDia && (cantStrellas < 30 ):
		cantStrellas +=1;
		add_child(estrallas.instance());
	add_child(nubes.instance())
	add_child(captus.instance());

func prob(val): #obtener la probabiliad pra pterodactylus
	randomize()
	var ran = stepify(rand_range(0,1),0.01);
	if(ran > 0.90):
		val = 7;
	return val;
	
func _on_timescore_timeout():
	if empezar:
		escor += 1;
	pass
