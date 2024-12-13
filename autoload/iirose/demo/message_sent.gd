
#----------------------
#版权所有：
#	李志鹏
#	新疆大学 计算机科学与技术学院 
#	计算机科学与技术 21-3班
#	毕业设计
#	学号：20211401239
#----------------------


extends PopupPanel



# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	IIROSE.sent_room_message($"Control/TabContainer/房间/VBoxContainer/TextEdit".text)
	pass # Replace with function body.


func _on_bullet_pressed() -> void:
	IIROSE.sent_bullet_message($"Control/TabContainer/弹幕/VBoxContainer/TextEdit".text)
	pass # Replace with function body.


func _on_side_pressed() -> void:
	IIROSE.sent_side_message($"Control/TabContainer/私聊/VBoxContainer/HBoxContainer/TextEdit".text,$"Control/TabContainer/私聊/VBoxContainer/TextEdit".text)
	pass # Replace with function body.



func _on_tab_container_tab_changed(tab: int) -> void:
	if tab==3:
		size.y=900
	else:
		size.y=300
	pass # Replace with function body.


func _on_cmd_pressed() -> void:
	IIROSE.sent_str($"Control/TabContainer/指令/VBoxContainer/TextEdit".text)
	pass # Replace with function body.
