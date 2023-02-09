extends ColorRect
#const
const INFOGRAPHIC = preload("res://MainScenes/MapScreen/Infographics/CityInfographic.tscn")
#vars
var city_index:int
var keep_infograph:bool = false
var infographic_id = null
var mouse_range:float = 20
var highlighted:bool = false
#-------------------------------------------------------------------------------
func _process(delta):
	if abs((rect_global_position - get_global_mouse_position()).length()) < mouse_range:
		modulate.g8 = 0
		highlighted = true
		if infographic_id == null:
			render_infographic(rect_global_position)
	else:
		modulate.g8 = 255
		highlighted = false
		if infographic_id != null:
			if keep_infograph == false:
				delete_infographic()

func _input(event):
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			if highlighted:
				if city_index == Global.current_city_index:
					keep_infograph = !keep_infograph
				for n in Global.route_data.size():
					if Global.route_data[n][Global.ROUTE.CONNECTION] == Vector2(city_index,Global.current_city_index) or Global.route_data[n][Global.ROUTE.CONNECTION] == Vector2(Global.current_city_index,city_index):
						print("select this route: ", self)
						Global.next_city_index = city_index
						StageManager.advance_scene("Desert")

#----------------------------INFOGRAPHIC----------------------------------------
func render_infographic(pos):
	var infographic = INFOGRAPHIC.instance()
	add_child(infographic)
	infographic.set_global_position(pos)
	infographic.city_index = city_index
	infographic_id = infographic

func delete_infographic():
	infographic_id.queue_free()
	infographic_id = null
