extends Node2D

onready var main_scene = "res://Main.tscn"
onready var pipe_scene = preload("res://Pipe.tscn")
onready var pipes = $Pipes
onready var pipe_spawn_timer = $PipeSpawnTimer
onready var bird := $Bird
var entered := false


func _ready():
	GameManager.speed = GameManager.init_speed
	randomize()


func _process(delta):
	if self.bird.global_position.x > 20:
		self.bird.global_position.x -= 20 * delta

func init_bg(bias: int, is_day: bool):
	$GameBackGround.global_position.x = bias
	$GameBackGround.choose(is_day)


func _on_Bird_game_ends():
	var main_instance = load(main_scene).instance()
	var bias = $GameBackGround.min_bias()
	var is_day = $GameBackGround.is_day
	GameManager.change_scene(self, main_instance)
	main_instance.init_bg(bias, is_day)


func _on_PipeSpawnTimer_timeout():
	_swpan_pipe()
	GameManager.speed *= GameManager.speed_factor
	self.pipe_spawn_timer.wait_time /= GameManager.speed_factor
	self.bird.gravity *= GameManager.speed_factor
	self.bird.up_speed *= GameManager.speed_factor


func _swpan_pipe():
	var pipe_instance = pipe_scene.instance()
	self.pipes.add_child(pipe_instance)
	pipe_instance.global_position.x = GameManager.width + 50
	var random_bias = randi() % 250
	pipe_instance.global_position.y += random_bias
