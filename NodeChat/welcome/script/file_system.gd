#----------------------
#版权所有：
#	李志鹏
#	新疆大学 计算机科学与技术学院 
#	计算机科学与技术 21-3班
#	毕业设计
#	学号：20211401239
#----------------------


extends Control
@export var file_messege:String="user://file_mes.txt"
signal edit_file(path:String)
var single:PackedScene=preload("res://NodeChat/welcome/tscn/single_file.tscn")
func _ready() -> void:
	var f=FileAccess.open(file_messege,FileAccess.READ)
	if f==null:
		f=FileAccess.open(file_messege,FileAccess.WRITE)
		f.store_string("[]")
		f.close()
	else:
		var str=f.get_as_text()
		#print(str)
		var js=JSON.parse_string(str)
		if js is Array:
			var file_array=js
			for i in file_array:
				var new_single=single.instantiate() as SingleFile
				add_single(new_single)
				new_single.root_path=i[0]
				if i[1]!=null:
					new_single.data_path=i[1]
				else:
					new_single.data_path=""
				
				
		f.close()
func add_single(ins:SingleFile):
	$ScrollContainer/VBoxContainer.add_child(ins)	
	ins.delete_self.connect(delete_request)		
	ins.edit_file_request.connect(edit_file_request)
	ins.changed.connect(save)
func save():
	#print("save")
	var new_array:Array=[]
	for i in $ScrollContainer/VBoxContainer.get_children():
		if i is SingleFile:
			new_array.append([i.root_path,i.data_path])
	var js=JSON.stringify(new_array)
	#print(new_array)
	var f=FileAccess.open(file_messege,FileAccess.WRITE)
	if f !=null:
		#print("f不为null")
		f.store_string(js)
		f.close()
func delete_request(s:SingleFile):
	if s.is_run:
		s._on_run_pressed()
	s.queue_free()
	await  get_tree().create_timer(0.2).timeout
	save()

func load_new_node(path:String):
	for i in $ScrollContainer/VBoxContainer.get_children():
		if i.root_path==path:
			return
	var new_single=single.instantiate() as SingleFile
	
	add_single(new_single)
	new_single.root_path=path
	save()
	pass
	

func _on_load_file_pressed() -> void:
	DisplayServer.file_dialog_show("选择节点集文件","","",false,DisplayServer.FILE_DIALOG_MODE_OPEN_FILE,PackedStringArray(["*.nodeset"]),load_file_selected)

	pass # Replace with function body.
func load_file_selected(status:bool,selected_paths:PackedStringArray,selected_filter_index:int):
	if status:
		load_new_node(selected_paths[0])
	
	pass

#func open_file():
	#DisplayServer.file_dialog_show("选择节点集文件"," "," ",false,DisplayServer.FILE_DIALOG_MODE_OPEN_FILE,PackedStringArray(),opened_file_selected)
	#
#func opened_file_selected(status:bool,selected_paths:PackedStringArray,selected_filter_index:int):
	#if status:
		#open_state_root(selected_paths[0])
		#

func _on_add_file_pressed() -> void:
	DisplayServer.file_dialog_show("保存节点集文件为","","",false,DisplayServer.FILE_DIALOG_MODE_SAVE_FILE,PackedStringArray(["*.nodeset"]),add_file_selected)
	pass # Replace with function body.
func add_file_selected(status:bool,selected_paths:PackedStringArray,selected_filter_index:int):
	if status:
		add_new_file(selected_paths[0])
func add_new_file(path:String):
	if not path.ends_with(".nodeset"):
		path+=".nodeset"
	var f=FileAccess.open(path,FileAccess.WRITE)
	if f!=null:
		f.store_string('[{"0":{"from_node_array":[],"next_node_array":[],"position_x":0,"position_y":0,"type":0,"mod_from":"basemod","mod_node":"状态节点"}},{"init_state":"0","judge_time":2,"time_to_delete_instance":30}]')
		f.close()
		load_new_node(path)
	
	pass
func edit_file_request(path:String):
	edit_file.emit(path)


func _on_refresh_file_pressed() -> void:
	for i in $ScrollContainer/VBoxContainer.get_children():
		i.queue_free()
	var f=FileAccess.open(file_messege,FileAccess.READ)
	if f==null:
		f=FileAccess.open(file_messege,FileAccess.WRITE)
		f.store_string("[]")
		f.close()
	else:
		var str=f.get_as_text()
		#print(str)
		var js=JSON.parse_string(str)
		if js is Array:
			var file_array=js
			for i in file_array:
				var new_single=single.instantiate() as SingleFile
				add_single(new_single)
				new_single.root_path=i[0]
				new_single.data_path=i[1]
				
		f.close()
	pass # Replace with function body.
