extends Node2D

onready var bg_day := $"Background-day" as Sprite
onready var bg_night := $"Background-night" as Sprite


func _ready():
	choose_background(true)


func choose_background(is_day:bool):
	var lz = [bg_day, bg_night]
	var idx := 0
	if is_day: idx = 0
	else: idx = 1
	lz[idx].show()
	lz[idx ^ 1].hide()
