extends Node

var nivel
var puntos

var datos_partida = {
	puntos = 0,
	nivel = "res://Scenes/Nivel 1.tscn"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#var path = File.new()
	#if !path.file_exists("user://RunAndJump_saves"):
	#	path.open("user://")
	#	path.make_dir("user://RunAndJump_saves")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func guardar_partida():
	var save = File.new()
	save.open("user://RunAndJump_saves/autosave.sav", File.WRITE)
	
	var datos_guardar = datos_partida
	datos_guardar.puntos = puntos
	datos_guardar.nivel = nivel
	
	save.store_line(to_json(datos_guardar))
	save.close()
	
func cargar_partida():
	var cargar = File.new()
	if !cargar.file_exists("user://RunAndJump_saves/autosave.sav"):
		print("ERROR AL CARGAR")
		puntos = 0
		nivel = "res://Scenes/Nivel 1.tscn"
		return
	cargar.open("user://RunAndJump_saves/autosave.sav", File.READ)
	var datos_cargar = datos_partida
	while !cargar.eof_reached():
		var dato_provisorio = parse_json(cargar.get_line())
		if dato_provisorio != null:
			datos_cargar = dato_provisorio
			
	puntos = datos_cargar.puntos
	nivel = datos_cargar.nivel
	print("CARGO ESTO Y NO SE QUE SERA")
	
	cargar.close()
