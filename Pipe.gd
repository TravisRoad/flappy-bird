extends Node2D

signal score_plus

var entered := false
var exited := false
var finished := false

onready var score_audio = $AudioStreamPlayer

func _ready():
	pass # Replace with function body.


func _process(delta):
	self.global_position.x -= GameManager.speed * 4 * delta


func _on_Area2D_body_entered(body):
	print("entered")
	self.emit_signal("score_plus")
	self.score_audio.play()

func _on_VisibilityNotifier2D_screen_entered():
	self.entered = true


func _on_VisibilityNotifier2D_screen_exited():
	self.exited = true
	if finished:
		self.get_parent().remove_child(self)


func _on_AudioStreamPlayer_finished():
	self.finished = true
	if exited:
		self.get_parent().remove_child(self)
