extends OptionButton

class_name NodeChatSelect
signal tab_select(ind:int)
var map_dic:Array[int]=[]

func _on_item_selected(index: int) -> void:
	if index<map_dic.size():
		tab_select.emit(map_dic[index])
	pass # Replace with function body.
