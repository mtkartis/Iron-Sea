extends Line2D
#const
const INFOGRAPHIC = preload("res://MainScenes/MapScreen/Infographics/RouteInfographic.tscn")
#vars
var cities_connected:Vector2
var infographic_id = null
var mouse_range:float = 20
var midpoint_position:Vector2
var highlighted:bool = false
#-------------------------------------------------------------------------------
func _ready():
#	call_deferred("set_midpoint")
	call_deferred("render_proximal")
	
#func _process(delta):
#	if abs((midpoint_position - get_global_mouse_position()).length()) < mouse_range:
#		modulate.g8 = 0
#		highlighted = true
#		if infographic_id == null:
#			render_infographic(midpoint_position)
#	else:
#		modulate.g8 = 255
#		highlighted = false
#		if infographic_id != null:
#			delete_infographic()

#func _input(event):
#	if event is InputEventMouseButton:
#		if Input.is_mouse_button_pressed(1):
#			if highlighted:
#				print("select this route: ", self)

#func set_midpoint():
#	var ends = Array(points)
#	var mid = ends[1]
#	var a = ColorRect.new()
#	add_child(a)
#	a.set_size(Vector2(3,3))
#	a.modulate.b8 = 100
#	a.set_global_position(mid)
#	midpoint_position = a.rect_global_position
		
func render_proximal():
#	print(cities_connected)
	if cities_connected.x == Global.current_city_index or cities_connected.y == Global.current_city_index:
		self_modulate.g8 = 0
		self_modulate.b8 = 0

#-----------------------------------INFOGRAPHIC---------------------------------
#func render_infographic(pos):
#	var infographic = INFOGRAPHIC.instance()
#	add_child(infographic)
#	infographic.set_global_position(pos)
#	infographic.city_connection = cities_connected
#	infographic_id = infographic
#
#func delete_infographic():
#	infographic_id.queue_free()
#	infographic_id = null
