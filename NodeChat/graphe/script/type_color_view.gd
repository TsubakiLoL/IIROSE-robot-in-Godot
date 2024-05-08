extends Control
var single=preload("res://NodeChat/graphe/tscn/type_color_single.tscn")

@onready var add_position=$VBoxContainer


func _ready() -> void:
	for i in ChatNodeGraph.type_num.keys():
		var s=single.instantiate() as TypeColorSingle
		s.set_information(ChatNodeGraph.type_color[i],ChatNodeGraph.type_name[i])
		add_position.add_child(s)
		
