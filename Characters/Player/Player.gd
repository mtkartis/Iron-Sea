class_name Player
extends KinematicBody2D

const SPEED = 300

var gunDamage = 10
var velocity:Vector2 = Vector2.ZERO

onready var raycast = $RayCast2D

#-------------------------------------------------------------------------------
func _physics_process(_delta):
	var horiz_vector:float = Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT")
	if horiz_vector != 0.0:
		velocity.x = horiz_vector*SPEED
	else:
		velocity.x = 0
		
	velocity = move_and_slide(velocity,Vector2.UP)
	
	if is_on_floor():
		if Input.is_action_just_pressed("JUMP"):
			velocity.y -= 500
		else:
			velocity.y = 0
	else:
		velocity.y += 20

	raycast.set_cast_to(get_global_mouse_position() - raycast.global_position)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			shoot()

func shoot():
	var target = raycast.get_collider()
	if target is Enemy:
		target.damage(gunDamage)
