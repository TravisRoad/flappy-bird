extends Node

const width = 288
var speed = 50
var speed_factor = 1.02


func _ready():
	pass
	
func change_scene(old_node, new_node):
	self.get_parent().add_child(new_node)
	self.get_parent().remove_child(old_node)
