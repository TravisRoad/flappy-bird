extends Control

signal restart

onready var score_texture := [
	preload("res://flappy-bird-assets/sprites/0.png"),
	preload("res://flappy-bird-assets/sprites/1.png"),
	preload("res://flappy-bird-assets/sprites/2.png"),
	preload("res://flappy-bird-assets/sprites/3.png"),
	preload("res://flappy-bird-assets/sprites/4.png"),
	preload("res://flappy-bird-assets/sprites/5.png"),
	preload("res://flappy-bird-assets/sprites/6.png"),
	preload("res://flappy-bird-assets/sprites/7.png"),
	preload("res://flappy-bird-assets/sprites/8.png"),
	preload("res://flappy-bird-assets/sprites/9.png"),
]

onready var High = $HBoxContainer/High
onready var Low = $HBoxContainer/Low

onready var Panel_Score_High = $Node2D/ScoreContainer/High
onready var Panel_Score_Low = $Node2D/ScoreContainer/Low

onready var Best_High = $Node2D/BestScoreContainer/High
onready var Best_Low = $Node2D/BestScoreContainer/Low

var score = 0

func _ready():
	$Sprite/OpacTween.interpolate_property($Sprite, NodePath("modulate:a8"), 0, 192, 1.0, Tween.TRANS_SINE, Tween.EASE_IN)


func score_up():
	score += 1
	var l:int = score % 10
	var h:int = score / 10 % 10
	High.texture = score_texture[h]
	Low.texture = score_texture[l]
	
	Panel_Score_High.texture = score_texture[h]
	Panel_Score_Low.texture = score_texture[l]


func game_end():
	$Sprite/OpacTween.start() # 背景渐变
	
	# 获得历史最大分数
	var save_dict = GameManager.load_record("user://score.save")
	var best := 0
	if save_dict != null:
		best = save_dict['best']
	if best < score:
		best = score
		GameManager.save_record("user://score.save", {"best": score})
	
	var l:int = best % 10
	var h:int = best / 10 % 10
	
	Best_High.texture = score_texture[h]
	Best_Low.texture = score_texture[l]
