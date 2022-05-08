extends Node2D


var is_day = true

onready var bg0 = $bg0
onready var bg1 = $bg1
onready var bg2 = $bg2


func _ready():
	randomize()
	choose(randi() % 2 == 0)


func _process(delta):
	self.global_position.x -= GameManager.speed * delta
	for bg in [bg0, bg1, bg2]:
		if bg.global_position.x < -GameManager.width:
			bg.global_position.x += 2 * GameManager.width
			print("swap")

	
func choose(_is_day:bool):
	self.is_day = _is_day
	bg0.choose_background(_is_day)
	bg1.choose_background(_is_day)
	bg2.choose_background(_is_day)


func min_bias() -> int:
	var _min = bg0.global_position.x
	for bg in [bg1, bg2]:
		var _x = bg.global_position.x
		if _min > _x: _min = _x
	return _min
