extends Sprite

var timer
var fondo

export (StreamTexture) var textura1
export (StreamTexture) var textura2
export (StreamTexture) var textura3


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = 0
	fondo = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if timer >= 0.5:
		
		if fondo == 1:
			$Sprite.texture = textura1
		elif fondo == 2:
			$Sprite.texture = textura2
		elif fondo == 3:
			$Sprite.texture = textura3
		
		timer = 0
		fondo += 1
		if fondo == 4:
			fondo = 1
		
	timer += delta
	
	
