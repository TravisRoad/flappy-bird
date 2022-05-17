extends Node2D

onready var main_scene = "res://Main.tscn"
onready var game_scene = "res://Game.tscn"
onready var pipe_scene = preload("res://Pipe.tscn")
onready var pipes = $Pipes
onready var pipe_spawn_timer = $PipeSpawnTimer
onready var bird := $Bird
var entered := false


func _ready():
	GameManager.speed = GameManager.init_speed
	GameManager.speed_factor = GameManager.init_speed_factor
	randomize()
	$AnimationPlayer.play("bird")
	bird.connect("hit", $Camera2D, "shake")


func _process(delta):
	pass

func init_bg(bias: int, is_day: bool):
	$GameBackGround.global_position.x = bias
	$GameBackGround.choose(is_day)


# 游戏结束
func _on_Bird_game_ends():
	GameManager.speed_factor = 1.0
	$CanvasLayer/UI/AnimationPlayer.play("up") # 升起记分牌
	$CanvasLayer/UI/Node2D/ButtonContainer/RestartButton.connect("pressed", self, "_game_restart")
	$CanvasLayer/UI/Node2D/ButtonContainer/MenuButton.connect("pressed", self, "_game_menu")
	$CanvasLayer/UI.game_end()


func _game_restart():
	var game_instance = load(game_scene).instance()
	var bias = $GameBackGround.min_bias()
	var is_day = $GameBackGround.is_day
	GameManager.change_scene(self, game_instance)
	game_instance.init_bg(bias, is_day)
	

func _game_menu():
	var main_instance = load(main_scene).instance()
	var bias = $GameBackGround.min_bias()
	var is_day = $GameBackGround.is_day
	GameManager.change_scene(self, main_instance)
	main_instance.init_bg(bias, is_day)


func _on_PipeSpawnTimer_timeout():
	_swpan_pipe()
	GameManager.speed *= GameManager.speed_factor
	self.pipe_spawn_timer.wait_time /= GameManager.speed_factor
	self.bird.gravity *= GameManager.speed_factor + 0.01
	self.bird.up_speed *= GameManager.speed_factor + 0.01


func _swpan_pipe():
	var pipe_instance = pipe_scene.instance()
	self.pipes.add_child(pipe_instance)
	pipe_instance.global_position.x = GameManager.width + 50
	var random_bias = randi() % 250
	pipe_instance.global_position.y += random_bias
	
