extends Node

const REC_RND = 0
const REC_ORD = 1
const objJuego = preload("res://Scenes/Juego.tscn")
const objMenu = preload("res://Scenes/Menu.tscn")

var modo = REC_RND
var record = [0, 0]

func _ready():
	randomize()
	leerMemoria()

func leerMemoria():
	if FileAccess.file_exists("user://save_game.dat"):
		var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
		var txt = file.get_as_text().split(",")
		record[REC_RND] = int(txt[REC_RND])
		record[REC_ORD] = int(txt[REC_ORD])

func escribirMemoria():
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_string(str(record[REC_RND]) + "," + str(record[REC_ORD]))
	file.close()
