class_name Pointer
extends Area2D

var colliding = false

func _process(_delta):
	#RAYCAST ARM
	global_position = get_global_mouse_position()
	
	colliding = (get_overlapping_areas() != [])

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			if colliding:
				var colliders = get_overlapping_areas()
				#loop through all collisions
				for i in colliders:
					if i is Interact:
						i.activate()
						break
					if i is Door:
						print("Knock knock...")
						break
