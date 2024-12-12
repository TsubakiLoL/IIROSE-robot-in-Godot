#----------------------
#版权所有：
#	李志鹏
#	新疆大学 计算机科学与技术学院 
#	计算机科学与技术 21-3班
#	毕业设计
#	学号：20211401239
#----------------------



extends PopupPanel
signal selected(type:int)


func _on_node_select_selected(type: int) -> void:
	selected.emit(type)
	self.hide()
	pass # Replace with function body.
