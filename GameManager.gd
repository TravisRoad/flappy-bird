extends Node

const width = 288
const init_speed = 50
const init_speed_factor = 1.01

var speed = 50
var speed_factor = 1.01


func _ready():
	pass

	
func change_scene(old_node, new_node):
	self.get_parent().add_child(new_node)
	self.get_parent().remove_child(old_node)


# save dict as json
func save_record(path, dict):
	var file := File.new()
	file.open(path, File.WRITE)
	file.store_line(var2str(dict))
	file.close()
	

func load_record(path):
	var file := File.new()
	file.open(path, File.READ)
	var content := file.get_as_text()
	file.close()
	if content.length() == 0:
		return null
	return str2var(content)
	
