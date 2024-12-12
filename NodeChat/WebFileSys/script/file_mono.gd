
#----------------------
#版权所有：
#	李志鹏
#	新疆大学 计算机科学与技术学院 
#	计算机科学与技术 21-3班
#	毕业设计
#	学号：20211401239
#----------------------


extends HBoxContainer
class_name FileMono
var id:int=0
var n_name:String=""
var n_edit:String=""
var n_intro:String=""
signal open_mes(n:String,edit:String,intro:String,nid:int)
signal download(id:int)
signal delete(id:int)
func set_mes(n:String,edit:String,intro:String,id:int):
	
	n_name=n
	n_edit=edit
	n_intro=intro
	self.id=id
	$Label.text=n
	$Label2.text=edit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_mes_pressed() -> void:
	open_mes.emit(n_name,n_edit,n_intro,id)
	pass # Replace with function body.


func _on_download_pressed() -> void:
	download.emit(id)
	pass # Replace with function body.


func _on_delete_pressed() -> void:
	delete.emit(id)
	pass # Replace with function body.
