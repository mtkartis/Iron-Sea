extends MarginContainer
#vars
var city_index:int
#child nodes
onready var city_label = $List/City
onready var coal_label = $List/Coal/Label
onready var scrap_label= $List/Scrap/Label
onready var ammo_label = $List/Ammo/Label

onready var coal_button = $List/Coal/Button
onready var scrap_button = $List/Scrap/Button
onready var ammo_button = $List/Scrap/Button
#signals
signal re_render_HUD
#-------------------------------------------------------------------------------
func _ready():
	call_deferred("set_labels")

func get_hub():
	var n
	var obj = self
	while n != "WaitingHub":
		obj = obj.get_parent()
		n = obj.name
	return obj
	
func set_labels():
	city_label.set_text("%s" % Global.city_data[city_index][0])
	coal_label.set_text("%s" % Global.city_data[city_index][3])
	scrap_label.set_text("%s" % Global.city_data[city_index][4])
	ammo_label.set_text("%s" % Global.city_data[city_index][5])

func _on_Button_pressed(id): #coal,scrap,ammo
	match id:
		"coal":
			if Global.money >= Global.city_data[city_index][3]:
				Global.coal += 10
				Global.money -= Global.city_data[city_index][3]
				print("Purchased 10 coal for %s" % Global.city_data[city_index][3])
			else:
				print("too poor")
		"scrap":
			if Global.money >= Global.city_data[city_index][4]:
				Global.scrap += 5
				Global.money -= Global.city_data[city_index][4]
				print("Purchased 5 coal for %s" % Global.city_data[city_index][4])
			else:
				print("too poor")
		"ammo":
			if Global.money >= Global.city_data[city_index][5]:
				Global.ammo += 20
				Global.money -= Global.city_data[city_index][5]
				print("Purchased 20 coal for %s" % Global.city_data[city_index][5])
			else:
				print("too poor")
	get_hub().label_HUD()
