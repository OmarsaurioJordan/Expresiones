extends Node2D

var frame = 0

func _ready():
	setCara(frame)

func setCara(ind):
	frame = ind
	for c in get_children():
		c.visible = false
	get_node("C" + str(ind)).visible = true
