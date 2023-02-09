extends Node2D

const STEP_SIZE = 50
enum {IDLE, MOVE}
var state = IDLE
var accelerationPercent:float = 0
onready var tween = $Tween


func _on_Steering_activate():
	if tween.is_active(): return
	tween.interpolate_property(
		self,
		"position:x",
		position.x,
		position.x + STEP_SIZE,
		1.0,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN
		)
	tween.start()
