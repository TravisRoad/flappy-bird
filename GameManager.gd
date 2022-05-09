extends Node

const width = 288
const init_speed = 50

var speed = 50
var speed_factor = 1.01


func _ready():
	pass
	
func change_scene(old_node, new_node):
	self.get_parent().add_child(new_node)
	self.get_parent().remove_child(old_node)
