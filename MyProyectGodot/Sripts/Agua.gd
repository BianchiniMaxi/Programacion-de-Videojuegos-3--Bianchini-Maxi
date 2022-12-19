extends Particles2D

#VARIABLES VARIAS
var direccion
var timer

#INICIALIZACION DE LAS VARIABLES
func _ready():
	direccion = rand_range(-15, 15)
	timer = 0

#MOVIMIENTO DE LAS PARTICULAS
func _process(delta):
	if timer >= 0.5:
		direccion *= -1
		$".".position.x += direccion
		timer = 0
		
	timer += delta
