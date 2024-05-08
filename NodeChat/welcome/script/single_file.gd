extends Control
class_name SingleFile
const STOP = preload("res://NodeChat/welcome/res/stop.png")
const START = preload("res://NodeChat/welcome/res/start.png")
@onready var run: Button = $HBoxContainer/run
@onready var edit: Button = $HBoxContainer/edit
@onready var _name: Label = $HBoxContainer/name
@onready var timer: Timer = $Timer
@onready var data: Label = $HBoxContainer/data
signal delete_self(s:SingleFile)
signal edit_file_request(path:String)
signal changed
var is_run:bool=false
var now_root:NodeRoot
var root_path:String:
	set(val):
		_name.text=val
		root_path=val
var data_path:String:
	set(val):
		data.text=val
		data_path=val


	

func _on_run_pressed() -> void:
	if not is_run and root_path!=null:
		var f=FileAccess.open(root_path,FileAccess.READ)
		if f!=null:
			var str=f.get_as_text()
			var res=Serializater.parse_string_new(str)
			if res!=null:
				now_root=res
				timer.wait_time=now_root.judge_time
				now_root.data_path=data_path
				now_root.start()
				timer.start()
				run.icon=STOP
				is_run=true
	elif is_run:
		if now_root!=null:
			now_root.end()
			now_root.delete()
			timer.stop()
			run.icon=START
			is_run=false
	pass # Replace with function body.


func _on_edit_pressed() -> void:
	edit_file_request.emit(root_path)
	pass # Replace with function body.

func set_file(f_path:String):
	var f=FileAccess.open(f_path,FileAccess.READ)
	if f!=null:
		root_path=f_path
func set_data(d_path:String):
	data_path=d_path
func _on_data_pressed() -> void:
	DisplayServer.file_dialog_show("选择数据集文件"," "," ",false,DisplayServer.FILE_DIALOG_MODE_OPEN_FILE,PackedStringArray(),data_selected)
	pass # Replace with function body.
func data_selected(status:bool,selected_paths:PackedStringArray,selected_filter_index:int):
	if status:
		data_path=selected_paths[0]
		changed.emit()


func _on_timer_timeout() -> void:
	if now_root!=null and now_root.is_start:
		now_root.judge()
	pass # Replace with function body.


func _on_delete_pressed() -> void:
	delete_self.emit(self)
	pass # Replace with function body.
