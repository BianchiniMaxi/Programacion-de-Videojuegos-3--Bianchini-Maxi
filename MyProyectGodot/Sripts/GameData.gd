extends Node

#VARIABLES VARIAS
var nivel
var puntos
var mayor_puntaje
var datos_partida
var tutorial_realizado

#SE CREA UN OBJETO DEL TIPO DATOS_PARTIDA
func _ready():
	datos_partida  = {
	puntos = 0,
	mayor_puntaje = 0,
	nivel = "res://Scenes/Nivel 1.tscn"
	}
	

#FUNCION ENCARGADA DE GUARDAR DATOS
func guardar_partida():
	var save = File.new() #VARIABLE DE TIPO FILE
	save.open("user://RunAndJump_autosave.sav", File.WRITE) #ABRIMOS EL ARCHIVO EN MODO ESCRITURA
	
	#SE CREA UNA VARIABLE DE TIPO DATOS_PARTIDA Y SE LES ASIGNA UN VALOR A SUS VARIABLES
	var datos_guardar = datos_partida
	datos_guardar.puntos = puntos
	datos_guardar.mayor_puntaje = mayor_puntaje
	datos_guardar.nivel = nivel
	
	#ESCRIBIMOS EN EL ARCHIVO Y LO CERRAMOS
	save.store_line(to_json(datos_guardar))
	save.close()
	

#FUNCION ENCARGADA DE CARGAR DATOS
func cargar_partida():
	var cargar = File.new() #VARIABLE DE TIPO FILE
	if !cargar.file_exists("user://RunAndJump_autosave.sav"): #VERIFICAMOS QUE EL ARCHIVO EXISTE, SI NO, LE ASIGNA VALORES A LAS VARIABLES NECESARIAS PARA EL GAMEPLAY
		puntos = 0
		mayor_puntaje = 0
		nivel = "res://Scenes/Nivel 1.tscn"
		return
	
	cargar.open("user://RunAndJump_autosave.sav", File.READ) #ABRIMOS EL ARCHIVO EN MODO LESCTURA
	var datos_cargar = datos_partida #VARIABLE DE TIPO FILE

	while !cargar.eof_reached():#CARGAMOS LOS DATOS SI NO LLEGA AL FINAL DEL ARCHIVO
		var dato_provisorio = parse_json(cargar.get_line())
		if dato_provisorio != null:
			datos_cargar = dato_provisorio
			
	puntos = datos_cargar.puntos
	mayor_puntaje = datos_cargar.mayor_puntaje
	nivel = datos_cargar.nivel
	
	cargar.close()
	

#COMPARAMOS PUNTAJE PARA OBTENER EL MAYOR
func comparar_puntajes():
	if puntos > mayor_puntaje:
		mayor_puntaje = puntos
	

#ACTUALIZAMOS EL CUADRO DE PUNTOS QUE SE MUESTRA AL GANAR EL NIVEL
func actualizar_puntos():
	get_tree().get_nodes_in_group("Puntos")[0].text = String(puntos)
