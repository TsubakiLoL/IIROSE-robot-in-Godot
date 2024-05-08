extends PopupPanel
signal selected(type:int)


func _on_node_select_selected(type: int) -> void:
	selected.emit(type)
	self.hide()
	pass # Replace with function body.
