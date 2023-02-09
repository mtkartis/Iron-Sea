extends Node
#constants
export(Script) var map_data_generator
#vars
const CITY_COUNT:int = 8
const SCREEN_MARGIN:float = 30.0
const CITY_SPACING:int = 150
const ROUTE_COUNT:int = 10

#child nodes
onready var screen:Object = $MarginContainer/VBoxContainer/ColorRect
onready var topography:Object = $Topography #this is the parent for all cities and routes
onready var HUD:Object = $MarginContainer/VBoxContainer/MapHUD
#-------------------------------------------------------------------------------
func _ready()->void:
	var top_left:Vector2 = screen.rect_global_position + Vector2.ONE * SCREEN_MARGIN
	var bottom_right:Vector2 = screen.rect_global_position + screen.rect_size - Vector2.ONE * SCREEN_MARGIN
	#(map_top_left_point:Vector2,map_bottom_right_point:Vector2,CITY_COUNT:int,ROUTE_COUNT:int,CITY_SPACING:float,topography_parent:Object)
	map_data_generator.generate(top_left, bottom_right, CITY_COUNT, ROUTE_COUNT, CITY_SPACING, topography)
	render_map()
	HUD.update_display()

#------------------------------------RENDER CITIES & ROUTES-----------------------------------------
func render_map()->void:
	match_city_data_to_object()
	match_route_data_to_object()
	place_city_marker()

func match_city_data_to_object()->void:
	for i in Global.city_data:
		Global.city_data[i][Global.CITY.ID].rect_global_position = Global.city_data[i][Global.CITY.GLOBAL_POS]
		Global.city_data[i][Global.CITY.ID].city_index = i

func match_route_data_to_object()->void:
	for i in Global.route_data:
		var index1:int = int(Global.route_data[i][Global.ROUTE.CONNECTION].x)
		var index2:int = int(Global.route_data[i][Global.ROUTE.CONNECTION].y)
		var city1:Vector2 = Global.city_data[index1][Global.CITY.GLOBAL_POS]
		var city2:Vector2 = Global.city_data[index2][Global.CITY.GLOBAL_POS]
		
		Global.route_data[i][Global.ROUTE.ID].points = [city1, city2]
		Global.route_data[i][Global.ROUTE.ID].cities_connected = Vector2(index1, index2)

func place_city_marker()->void:
	if Global.new_game:
		randomize()
		Global.current_city_index = rand_range(0,CITY_COUNT-1)
	Global.city_data[Global.current_city_index][1].self_modulate.g8 = 100
