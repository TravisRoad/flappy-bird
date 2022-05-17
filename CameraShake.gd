extends Camera2D


onready var shake := $CameraShake
const strength = 30
const duration = 0.5

func _ready():
	shake.interpolate_method(self, "disturb_offset", strength, 0, duration, Tween.TRANS_SINE, Tween.EASE_OUT, 0)


func disturb_offset(s : float):
	self.position.x = rand_range(-s,s)
	self.position.y = rand_range(-s,s)
	
	
func shake():
	shake.start()
