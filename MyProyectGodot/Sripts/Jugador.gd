extends KinematicBody2D

export (int) var gravedad = 2200
export (int) var velocidad_correr = 600
export (int) var fuerza_salto = -850

export (StreamTexture) var textura1
export (StreamTexture) var textura2
export (StreamTexture) var textura3

var velocidad = Vector2()
var muerto = false
var personajeSkin = 1
var tiempo_puede_morir = 0
var salto = false

func posicion_inicial():
	muerto = false
	position.y = -100
	position.x = 200
	get_parent().perder_vidas()
	

func get_input():
	velocidad.x = velocidad_correr
	
	if Input.is_action_pressed("ui_jump"):
		if is_on_floor():
			get_tree().get_nodes_in_group("SFX")[0].get_node("Audio_salto").play()
			gravedad = 2200
			velocidad.y += fuerza_salto
			salto = true
	
	if Input.is_action_pressed("ui_number_1"): 
		$Sprite.texture = textura1
		velocidad_correr = 600
		fuerza_salto = -850
		
	if Input.is_action_pressed("ui_number_2"):
		$Sprite.texture = textura2
		velocidad_correr = 600
		fuerza_salto = -1400
		
	if Input.is_action_pressed("ui_number_3"): 
		$Sprite.texture = textura3
		velocidad_correr = 800
		fuerza_salto = -850
		

func se_murio():
	if  tiempo_puede_morir > 1:
		muerto = true
		get_tree().get_nodes_in_group("SFX")[0].get_node("Audio_muerte").play()
	else:
		 muerto = false

func _physics_process(delta):
	get_input()
	
	if salto && velocidad.y >= 0:
		gravedad = 4000
		salto = false
	
	if position.y > 300:
		posicion_inicial()
	
	if muerto == true:
		get_tree().get_nodes_in_group("SFX")[0].get_node("Audio_muerte").play()
		tiempo_puede_morir = 0
		posicion_inicial()
	
	velocidad.y += gravedad * delta
	#print(velocidad.y)
	velocidad = move_and_slide(velocidad, Vector2(0, -1))
	
	tiempo_puede_morir += delta

func pararJugador():
	velocidad_correr = 0

func _on_Collision_Cuerpo_body_entered(body):
	if body.is_in_group("Mapa")  && muerto == false: 
		se_murio()
	
