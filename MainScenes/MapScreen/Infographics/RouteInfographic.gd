extends MarginContainer
#vars
var city_connection:Array
#child nodes
onready var city1 = $RoughLayout/CityLabels/City1
onready var city2 = $RoughLayout/CityLabels/City2
onready var mission_title = $RoughLayout/MissionInfo/MissionTitle
onready var mission_description = $RoughLayout/MissionInfo/MissionIcons/Description
onready var mission_reward = $RoughLayout/MissionInfo/RewardDisplay/RewardMoney
#-------------------------------------------------------------------------------
func _ready():
	call_deferred("render_label","city labels")
	
func render_label(item):
	match item:
		"city labels":
			city1.set_text(Global.city_data[city_connection[0]][0])
			city2.set_text(Global.city_data[city_connection[1]][0])
		"mission description":
			pass
		"mission reward":
			pass
