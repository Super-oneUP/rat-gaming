extends CharacterBody2D

@export var walkspeed:= 150.0
@export var runspeed:= 300.0
@export var jumpforce:= 360.0
@export var gravity:= 1000.0
@onready var anim = $Player/AnimationPlayer
@onready var camera = $Camera2D
@onready var sprite = $Player
@onready var dashtime= $dashtime
@onready var clingtime= $clingtime
@onready var hitbox = $CollisionShape2D
var skin=0
var facing=1
var dashed=0

func _physics_process(delta: float) -> void:
	if dashtime.is_stopped() and clingtime.is_stopped():
		hitbox.shape.size.x=12
		hitbox.position.x=0.0
	else:
		hitbox.shape.size.x=22
		hitbox.position.x=5.0*facing
	var horizinput := 0.0
	if dashtime.is_stopped():
		if clingtime.is_stopped():
			if Input.is_action_pressed("Right"):
				horizinput += 1
				sprite.flip_h = false
				facing=1
			if Input.is_action_pressed("Left"):
				horizinput -= 1
				sprite.flip_h = true
				facing=-1
		if Input.is_action_pressed("Run"):
			velocity.x=move_toward(velocity.x,horizinput*runspeed,delta*1000)
		else:
			velocity.x=move_toward(velocity.x,horizinput*walkspeed,delta*1000)
	if Input.is_action_just_pressed("Dash"):
		if not velocity.y==0:
			if dashed == 0:
				dashed = 1
				dashtime.start()
				velocity.y=-150
				$dash.play()
	if not dashtime.is_stopped():
	
		velocity.y-=600*delta
		if facing == 1:
			velocity.x=500
		else:
			velocity.x=-500
		if is_on_wall():
				dashtime.stop()
				clingtime.start()
				$cling.play()
		if is_on_floor():
			dashtime.stop()
	if not clingtime.is_stopped():
		velocity.y=1
		if Input.is_action_just_pressed("Jump"):
			$jump.play()
			velocity.y=-jumpforce*1.3
			dashed = 0
			clingtime.stop()
		if Input.is_action_just_pressed("fall or mine"):
				clingtime.stop()
	if is_on_floor():
		velocity.y=0
		dashed=0
		if Input.is_action_just_pressed("Jump"):
			$jump.play()
			if not Input.is_action_pressed("Run"):
				velocity.y= -(jumpforce+abs(velocity.x)*0.2)
			else:
				velocity.y=-jumpforce
		if abs(velocity.x)>0.1:
			anim.play("walk", -1, abs(velocity.x)*0.01)
		else:
				anim.play("idle")
	else:
		if velocity.y < 0:
			anim.play("jump")
		else:
			if clingtime.is_stopped():
				anim.play("fall")
			
			else:
				anim.play("walljump")
		velocity.y+=gravity*delta
	move_and_slide()
	if not dashtime.is_stopped():
		anim.play("dash")
	if Input.is_action_just_pressed("skin debug"):
		skin += 1
		if skin == 1:
			$Player.texture = preload ("res://art/rat skins/pizza rat.png")
		if skin == 2:
			$Player.texture = preload ("res://art/rat skins/doombringer.png")
		if skin == 3:
			$Player.texture = preload ("res://art/rat skins/transparent rat.png")
		if skin > 3:
			skin = 0
			$Player.texture = preload ("res://art/rat.png")
