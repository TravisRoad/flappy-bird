extends Control

onready var texture := $TextureRect
export(PackedScene) var GAME_SCENE
var game_instance: Node2D

func _ready():
	self.game_instance = GAME_SCENE.instance()


func _input(event):
	if event.is_action_pressed("lmb"):
		print("game start")
		var bias = $GameBackGround.min_bias()
		var is_day = $GameBackGround.is_day
		GameManager.change_scene(self, self.game_instance)
		self.game_instance.init_bg(bias, is_day)
		_start()


func init_bg(bias: int, is_day: bool):
	$GameBackGround.global_position.x = bias
	$GameBackGround.choose(is_day)


func _start():
	pass
	

