extends Node
#vars
var money:int = 5
var coal:int = 50
var scrap:int = 50
var ammo:int = 100
var fuel:float = 20
var hull_health:float = 1
var current_city_index:int
var next_city_index:int
var new_game:bool = true
var pause:bool = false
var exit_pressed:bool = false

enum CITY {NAME,ID,GLOBAL_POS,COAL,SCRAP,AMMO}
enum ROUTE {ID,CONNECTION}

#dictionary
var city_data:Dictionary = {} #gen_order:[name:String, obj_id:Object, global_pos:Vector2, coal:int ,scrap:int ,ammo:int]
var route_data:Dictionary = {} #gen_order:[route_object:Object, Vector2(city1,city2)]
var possible_city_names:Dictionary = {
	0:"Thod",
	1:"Amar",
	2:"Vern",
	3:"Pola",
	4:"Naen",
	5:"Juli",
	6:"Olla",
	7:"Hyur",
	8:"Loid",
	9:"Anvi",
	10:"Zoon",
	11:"Jool",
	12:"Kaea",
	13:"Fryn",
	14:"Deew",
	15:"Qine",
	16:"Xden",
	17:"Sdof",
	18:"Zsou",
	19:"Dokl",
	20:"Eovy",
	21:"Rcom",
	22:"Tyce",
	23:"Nund",}

func _unhandled_key_input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("EXIT"):
			pause = !pause
			exit_pressed = !exit_pressed
			print("PAUSE")
		if Input.is_action_just_pressed("INTERACT"):
			if exit_pressed:
				exit_pressed = false
