extends KinematicBody2D

onready var animated_sprite = $AnimatedSprite
onready var audio_player = $AudioPlayer
onready var die_audio_player = $DieAudioPlayer
onready var hit_audio_player = $HitAudioPlayer
onready var collision := $CollisionShape2D

signal game_ends
signal hit

const alpha = PI * 2
var rotation_speed = - PI / 5

var gravity = 400
var fall_speed = 0
var up_speed = -150

const init_rotation_speed = PI / 15

var color_list := ["red", "blue", "yellow"]

var alive := true

var exited := false
var death_audio_end := false


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var idx = randi() % 3
	var color = color_list[idx]
	animated_sprite.animation = color
	print(self.rotation)
	print(self.rotation_speed)
	
	_fly()


func _input(event):
	if not alive: return
	
	# 点击鼠标左键
	if event.is_action_pressed("lmb") || event.is_action_pressed("ui_accept"):
		_fly()


func _fly():
	self.fall_speed = self.up_speed
	self.rotation_speed = - PI
	audio_player.play()
	animated_sprite.play()


func _process(delta):
	# fall
	var _y = self.global_position.y + self.fall_speed * delta
	if _y < 0: _y = 0
	self.global_position.y = _y
	self.fall_speed += self.gravity * delta
	# rotate
	var _rotation = self.rotation + self.rotation_speed * delta
	self.rotation_speed += self.alpha * delta
	self.rotation = clamp(_rotation, - PI / 5, PI * 2 / 5)
	
	if self.rotation < - PI / 5 + 0.1:
		self.rotation_speed = self.init_rotation_speed


func _physics_process(_delta):
	var collision_info := self.move_and_collide(Vector2.ZERO)
	if collision_info:
		self.emit_signal("hit")
		_game_over(true)


func _on_AnimatedSprite_animation_finished():
	animated_sprite.frame = 0
	animated_sprite.stop()


func _on_VisibilityNotifier2D_screen_exited():
	print("bird exit the screen")
	if alive:
		_game_over(false)
	# 不管怎么样都是在鸟从屏幕消失后才能结束游戏
	self.exited = true
	if self.death_audio_end:
		self.emit_signal("game_ends")


func _game_over(is_punch):
	alive = false
	collision.set_deferred("disabled", true)
	if is_punch: hit_audio_player.play()
	die_audio_player.play()
	self.fall_speed += 200
	self.rotation_speed += PI * 2
	print("game over")
	

func _on_DieAudioPlayer_finished():
	self.death_audio_end = true
	if self.exited:
		self.emit_signal("game_ends")
