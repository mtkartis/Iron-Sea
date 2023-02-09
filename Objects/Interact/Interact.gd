class_name Interact
extends Area2D

enum TYPE{ONE_SHOT, TOGGLE, CLICK_IN_OUT}
export(TYPE) var type = TYPE.CLICK_IN_OUT

signal activate


func activate():
	print("ACTIVE " + name)
#	match type:
#		TYPE.CLICK_IN_OUT:
#			emit_signal("activate")
#			yield()
	emit_signal("activate")
