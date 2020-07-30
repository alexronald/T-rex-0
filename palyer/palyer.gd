extends KinematicBody2D
var alturaSalto = 60;
var graveda ;
var mover = Vector2.ZERO
var estaMuerto = false;
var doblesalto = 1;

func _ready():
	graveda = 2 * alturaSalto/ pow(0.2,2);
	$Sprite.animation = "stop";
	pass

func _physics_process(delta):
	if !is_on_floor():
			mover.y += graveda*delta;
	if get_parent().getEnpezando():
		if Input.is_action_pressed("ui_down") && is_on_floor():
			$CollisionShape2D.disabled = true;
			$CollisionShape2D2.disabled = false;
			$Sprite.animation = "inclinarse";
		elif Input.is_action_just_pressed("ui_up") && is_on_floor():
			mover.y = -sqrt(3*graveda*alturaSalto);
			$audio/song.playing=true
		else:
			$CollisionShape2D.disabled = false;
			$CollisionShape2D2.disabled = true;
			$Sprite.animation = "idle";
		
	mover = move_and_slide(mover,Vector2(0,-1));
	
	if get_slide_count() > 0:
		var col = get_slide_collision(get_slide_count() -1).collider;
		if col.is_in_group("captus"):
			$Sprite.animation = "muerto"
			get_parent().finJuego();
			$audio/collision.playing = true;
	pass

#func doblesalto():
#	if estaMuerto:
#		$Sprite.animation = "muerto";
#	else:
#		if !is_on_floor():
#			mover.y += graveda*delta;
#			pass
#		if Input.is_action_just_pressed("ui_up") && doblesalto > 0:
#	#		mover.y = -sqrt(5*graveda*salto);
#			mover.y = -sqrt(3*graveda*alturaSalto);
#			doblesalto -=1
#		if is_on_floor():
#			doblesalto = 1
#
#		mover = move_and_slide(mover,Vector2(0,-1))
