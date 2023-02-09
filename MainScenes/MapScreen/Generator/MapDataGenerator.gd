extends Node
#constants
const ROUTE = preload("res://MainScenes/MapScreen/Components/Route.tscn")
const CITY = preload("res://MainScenes/MapScreen/Components/CityMarker.tscn")

enum AVG {COAL = 5,SCRAP = 4,AMMO = 5}

#-------------------------------------------------------------------------------
static func generate(
	map_tl_point:Vector2,
	map_br_point:Vector2,
	city_count:int,
	route_count:int,
	city_spacing:float,
	topography_parent:Object)->void:
	
	match Global.new_game:
		true:
			var city_names_array:Array = generate_city_names(city_count)
			var city_price_array:Array = generate_city_price_data(city_count)
			var city_id_array:Array = generate_city_objects(city_count, topography_parent)
			var city_pos_array:Array = randomize_city_global_positions(map_tl_point, map_br_point, city_count, city_spacing)
			export_city_data_to_global(city_names_array, city_id_array, city_pos_array, city_price_array)
			
			var route_ids:Array = generate_route_objects(route_count, topography_parent)
			var route_points:Array = generate_route_points(route_count)
			export_route_data_to_global(route_ids, route_points)
		false:
			var city_id_array:Array = generate_city_objects(city_count, topography_parent)
			update_global_export_obj_data(city_id_array)
	Global.new_game = false

#--------------------------------GLOBAL COMPILERS-------------------------------
static func export_city_data_to_global(names:Array, ids:Array, positions:Array, prices:Array)->void:
	for i in names.size():
		#	#:[city_name,city_object_id,city_position,coal,scrap,ammo]
		Global.city_data[i] = [names[i], ids[i], positions[i], prices[i][0], prices[i][1], prices[i][2]]

static func update_global_export_obj_data(ids:Array)->void:
	for i in ids.size():
		Global.city_data[i][1] = ids[i]

static func export_route_data_to_global(route_ids:Array, route_points:Array)->void:
		for i in route_ids.size():
			Global.route_data[i] = [route_ids[i], route_points[i]]

#--------------------------CITY DATA--------------------------------------------
static func generate_city_names(city_count:int)->Array:
	var data:Array = []
	var index_keeper:Array = []
	while index_keeper.size() < city_count:
		randomize()
		var index:int = randi() % Global.possible_city_names.size()
		if index_keeper.find(index) == -1:
			index_keeper.append(index)
	for n in index_keeper.size():
		data.append(Global.possible_city_names[index_keeper[n]])
	return data

static func generate_city_price_data(city_count:int)->Array:
	var data:Array = []
	for i in city_count:
		randomize()
		var coal:int = AVG.COAL + (randi() % 7) - 3
		var scrap:int = AVG.SCRAP + (randi() % 7) - 3
		var ammo:int = AVG.AMMO + (randi() % 7) - 3
		data.append([coal,scrap,ammo])
	return data

static func generate_city_objects(city_count:int, parent:Object)->Array:
	var data:Array = []
	for i in city_count:
		var city:Object = CITY.instance()
		city.set_size(Vector2(5,5))
		parent.add_child(city)
		data.append(city)
	return data

static func randomize_city_global_positions(tl:Vector2, br:Vector2, city_count:int, city_spacing:float)->Array:
	var data:Array = []
	while data.size() < city_count:
		randomize()
		var coords = Vector2(rand_range(tl.x,br.x),rand_range(tl.y,br.y))
		data.append(coords)
		for n in data.size():
			if n == data.size()-1:
				break
			var position_check = abs((data[n] - data[-1]).length())
			if position_check < city_spacing:
				data.pop_back()
				break
	return data

#-----------------------------ROUTE DATA----------------------------------------
static func generate_route_points(route_count:int)->Array:
	#HOW THIS WORKS:
	#Iterate over all city points
	#Connect each city to the nearest city neighbour,
	#unless it is already connected, then connect to second closest neighbour, etc...
	#if more routes than cities, connect random cities together, unless already connected
	var data:Array = [] #[pair:Vector2]
	while data.size() < route_count:
		#for each route
		for i in route_count:
			var current_city_index:int = 0
			var current_global_position:Vector2 = Vector2.ZERO
			#mitigate having more routes than cities
			if i < Global.city_data.size():
				current_global_position = Global.city_data[i][Global.CITY.GLOBAL_POS]
				current_city_index = i
			else:
				randomize()
				var x:int = randi() % Global.city_data.size()
				current_global_position = Global.city_data[x][Global.CITY.GLOBAL_POS]
				current_city_index = x
			#interate over list of cities
			var closest_distance:float = INF
			var closest_city_index:int = -1
			for n in Global.city_data.size():
				if i != n:
					#check if proposed route is already connected
					if data.find(Vector2(i,n)) == -1 and data.find(Vector2(n,i)) == -1:
						#compare current and target city, distance, update closest city
						var target_global_position:Vector2 = Global.city_data[n][Global.CITY.GLOBAL_POS]
						var distance:float = abs((current_global_position - target_global_position).length())
						if distance < closest_distance:
							closest_distance = distance
							closest_city_index = n
			data.append(Vector2(current_city_index,closest_city_index))
	
#	var data:Array = []
#	var city_n = Global.city_data.size()
#	#for each route
#	for c in route_count:
#		var current_city_position:Vector2 = Vector2.ZERO
#		var current_city_index:int = 0
#		#if routes are more than cities
#		if c > city_n-1:
#			randomize()
#			var rando_city_index:int = randi() % Global.city_data.size()
#			var index = Global.city_data[rando_city_index]
#			current_city_position = index[2]
#			current_city_index = rando_city_index
#		#if routes are less than cities
#		else:
#			var index = Global.city_data[c]
#			current_city_position = index[2]
#			current_city_index = c
#		var closest_city_distance = INF
#		var closest_city_index:int = -1
#		for n in city_n:
#			var index2 = Global.city_data[n]
#			if n == current_city_index:
#				continue
##			print("length: ",(current_city_position - index2[2]).length())
#			if abs((current_city_position - index2[2]).length()) < closest_city_distance:
#				if data.find([n,current_city_index]) == -1 and data.find([current_city_index,n]) == -1:
#					closest_city_distance = (current_city_position - index2[2]).length()
#					closest_city_index = n
#		data.append(Vector2(current_city_index,closest_city_index))
	print(data)
	return data

static func generate_route_objects(route_count:int, parent:Object)->Array:
	var data:Array = []
	for i in route_count:
		var route:Object = ROUTE.instance()
		parent.add_child(route)
		data.append(route)
	return data
