class_name Door
extends Area2D

export(PackedScene) var goes_to
export(String) var key

func open():
	if get_tree().change_scene(goes_to.resource_path) == OK:
		print("entered door to " + goes_to.resource_path)
	else:
		print("DOOR ERROR")

func set_player_to_position():
	#check if there is player
	#set positions equal
	pass
