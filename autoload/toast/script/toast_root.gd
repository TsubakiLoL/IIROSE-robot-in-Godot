
#----------------------
#版权所有：
#	李志鹏
#	新疆大学 计算机科学与技术学院 
#	计算机科学与技术 21-3班
#	毕业设计
#	学号：20211401239
#----------------------


extends CanvasLayer

@onready var toast_tscn=preload("res://autoload/toast/tscn/toast.tscn")
# Called when the node enters the scene tree for the first time.
func popup(str:String):
	var new_toast=toast_tscn.instantiate()
	
	
	$pos/VBoxContainer.add_child(new_toast)
	new_toast.set_text(str)
	pass
