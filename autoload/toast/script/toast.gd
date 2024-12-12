
#----------------------
#版权所有：
#	李志鹏
#	新疆大学 计算机科学与技术学院 
#	计算机科学与技术 21-3班
#	毕业设计
#	学号：20211401239
#----------------------



extends PanelContainer


func set_text(str:String):
	$Label.text=str


func _on_timer_timeout() -> void:
	self.queue_free()
	pass # Replace with function body.
