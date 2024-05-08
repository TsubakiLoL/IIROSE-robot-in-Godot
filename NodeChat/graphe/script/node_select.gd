extends Control
@onready var line_edit: LineEdit = $LineEdit
@onready var item_list: ItemList = $ItemList
signal selected(type:int)
var now_contain_item:Array=[]
func _ready() -> void:
	update("")
	pass

func update(str:String):
	now_contain_item.clear()
	item_list.clear()
	if str!="":
		for i in ChatNodeGraph.node_name.keys():
			if ChatNodeGraph.node_name[i].contains(str):
				now_contain_item.append([i,ChatNodeGraph.node_name[i]])
				item_list.add_item(ChatNodeGraph.node_name[i])
	else:
		for i in ChatNodeGraph.node_name.keys():
			now_contain_item.append([i,ChatNodeGraph.node_name[i]])
			item_list.add_item(ChatNodeGraph.node_name[i])


func _on_item_list_item_selected(index: int) -> void:
	selected.emit(now_contain_item[index][0])
	pass # Replace with function body.


func _on_line_edit_text_changed(new_text: String) -> void:
	update(new_text)
	pass # Replace with function body.
