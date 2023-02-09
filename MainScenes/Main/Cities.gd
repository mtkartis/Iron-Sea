extends Node

export(float) var cityDistance = 1000.0


onready var beginningCity = $City1
onready var endCity = $City2

func _ready():
	setDistance()

func setDistance():
	endCity.global_position.x = cityDistance + 500
