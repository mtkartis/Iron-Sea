class_name Enemy
extends Area2D

export(Vector2) var hp = Vector2.ONE
export(int) var damage = 1


func damage(damageAmount:float):
	print(damageAmount)
