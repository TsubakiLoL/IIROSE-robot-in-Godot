extends Control
@export var download_path:String="user://"
@export var file_mono:PackedScene
@onready var search_text: LineEdit = $VBoxContainer/HBoxContainer/search_text
@onready var add_position: VBoxContainer = $VBoxContainer/ScrollContainer/add_position
@onready var n_name: Label = $DrawerContainer/Panel/MarginContainer/Control/VBoxContainer/n_name
@onready var n_editor: Label = $DrawerContainer/Panel/MarginContainer/Control/VBoxContainer/n_editor
@onready var n_id: Label = $DrawerContainer/Panel/MarginContainer/Control/VBoxContainer/n_id
@onready var n_intro: Label = $DrawerContainer/Panel/MarginContainer/Control/VBoxContainer/ScrollContainer/VBoxContainer/PanelContainer/n_intro
@onready var peer:StreamPeerTCP=StreamPeerTCP.new()
@onready var upload_nodeset_name: LineEdit = $upload_panel/Panel/upload_nodeset_name
@onready var upload_nodeset_editor: LineEdit = $upload_panel/Panel/upload_nodeset_editor
@onready var upload_nodeset_path: LineEdit = $upload_panel/Panel/upload_nodeset_path
@onready var upload_nodeset_password: LineEdit = $upload_panel/Panel/upload_nodeset_password
@onready var upload_nodeset_intro: TextEdit = $upload_panel/Panel/upload_nodeset_intro
@onready var delete_nodeset_id: LineEdit = $delete_panel/Panel/delete_nodeset_ID

@onready var upload_panel: DrawerContainer = $upload_panel

@onready var delete_nodeset_password: LineEdit = $delete_panel/Panel/delete_nodeset_password
@onready var delete_panel: DrawerContainer = $delete_panel
@onready var change_download_file_panel: PopupPanel = $change_download_file_panel
@onready var download_file_path: LineEdit = $change_download_file_panel/HBoxContainer/download_file_path

var is_connect_to_server:bool=false:
	set(val):
		is_connect_to_server=val
		if is_connect_to_server:
			peer=StreamPeerTCP.new()
			peer.connect_to_host("8.219.243.185",7890)
			set_process(true)
			refresh()
			
			pass
		else:
			set_process(false)
			peer.disconnect_from_host()
		
		
		pass
var config_file:String="user://config.txt"

var port:int=7890
@onready var mes_win: DrawerContainer = $DrawerContainer
func _ready() -> void:
	set_process(false)
	change_download_file_panel.popup_window=false
	download_path=read_download_path()
	
func refresh():

	if search_text.text!="":
		search()
	else:
		peer.call_deferred("poll")
		peer.call_deferred("put_utf8_string","f")


func search():
	if search_text.text!="":
		peer.call_deferred("poll")
		peer.call_deferred("put_utf8_string","s"+search_text.text)
	
	
	pass
func open_window(nname:String,neditor:String,nintro:String,nid:int):
	n_name.text=nname
	n_editor.text=neditor
	n_intro.text=nintro
	n_id.text=str(nid)
	mes_win.change_open()
	
	pass
func get_fresh(str:String):
	var json=JSON.parse_string(str)
	if json is Array:
		for i in add_position.get_children():
			i.queue_free()
		for i in json:
			if i is Dictionary:
				var new_file:FileMono=file_mono.instantiate()
				add_position.add_child(new_file)
				new_file.set_mes(i["n"],i["e"],i["i"],i["id"])
				new_file.open_mes.connect(open_window)
				new_file.download.connect(start_download)
				new_file.delete.connect(delete_nodeset)
	pass
func downloaded(str:String):
	var json=JSON.parse_string(str)
	if json is Dictionary:
		var n=json["n"]
		var v=json["v"]
		if n is String and v is String:
			var path:String=download_path
			if path.ends_with("/"):
				path=path+n+".nodeset"
			else:
				path=path+"/"+n+".nodeset"
			var f=FileAccess.open(path,FileAccess.WRITE)
			if f!=null:
				f.store_string(v)
				f.close()
				Toast.popup(n+".nodeset 下载完成")
				f=FileAccess.open("user://file_mes.txt",FileAccess.READ)
				if f!=null:
					var st=f.get_as_text()
					f.close()
					var arr=JSON.parse_string(st)
					if arr is Array:
						arr.append([path,""])
						f=FileAccess.open("user://file_mes.txt",FileAccess.WRITE)
						f.store_string(JSON.stringify(arr))
						f.close()
			else:
				Toast.popup("下载失败，目录非法！")
		
	pass

signal linked_num_update(num_int:int)
func _process(delta: float) -> void:
	if peer!=null:
		peer.poll()
		if peer.get_status()==StreamPeerTCP.STATUS_NONE or peer.get_status()==StreamPeerTCP.STATUS_ERROR:
			
			peer.connect_to_host("8.219.243.185",port)
			return
		if peer.get_available_bytes()>=2:
			var str=peer.get_utf8_string()
			if str is String:
				if str.begins_with("f"):
					str=str.right(str.length()-1)
					get_fresh(str)
				elif str.begins_with("d"):
					str=str.right(str.length()-1)
					downloaded(str)
					pass
				elif str.begins_with("l"):
					var num:int=int(str.right(-1))
					linked_num_update.emit(num)
					
	
	pass
func start_download(id:int):
	if peer!=null:
		peer.poll()
		peer.put_utf8_string("d"+str(id))


func _on_upload_nodeset_select_file_pressed() -> void:
	DisplayServer.file_dialog_show("选择节点集文件"," "," ",false,DisplayServer.FILE_DIALOG_MODE_OPEN_FILE,PackedStringArray(),upload_selected)
	pass # Replace with function body.
func upload_selected(status:bool,selected_paths:PackedStringArray,selected_filter_index:int):
	if status:
		upload_nodeset_path.text=selected_paths[0]


func _on_upload_pressed() -> void:
	upload_panel.change_open()
	pass # Replace with function body.


func _on_upload_action_pressed() -> void:
	var n:String=upload_nodeset_name.text
	var e:String=upload_nodeset_editor.text
	var i:String=upload_nodeset_intro.text
	var p:String=upload_nodeset_password.text
	var v_path:String=upload_nodeset_path.text
	if n!="" and e!="" and i!="" and p!="" and v_path!="":
		
		var f=FileAccess.open(v_path,FileAccess.READ)
		if f!=null:
			var text=f.get_as_text()
			var new_dic:Dictionary={
				"n":n,
				"e":e,
				"i":i,
				"p":p,
				"v":text
			}
			peer.poll()
			peer.put_utf8_string("*"+JSON.stringify(new_dic))
			Toast.popup("上传成功")
			
		else:
			Toast.popup("文件不存在！")
		pass
	else:
		Toast.popup("存在未填写内容！")
	pass # Replace with function body.


func _on_delete_hide_pressed() -> void:
	delete_panel.change_open()
	pass # Replace with function body.

func delete_nodeset(id:int):
	
	delete_panel.change_open()
	delete_nodeset_id.text=str(id)
	
	pass
func _on_delete_node_set_pressed() -> void:
	var id=int(delete_nodeset_id.text)
	var password=delete_nodeset_password.text
	var new_dic:Dictionary={
		"id":id,
		"p":password
	}
	peer.poll()
	peer.put_utf8_string("#"+JSON.stringify(new_dic))
	pass # Replace with function body.


func _on_open_download_file_pressed() -> void:
	OS.shell_open(ProjectSettings.globalize_path(download_path))
	pass # Replace with function body.


func _on_change_download_file_pressed() -> void:
	download_file_path.text=download_path
	change_download_file_panel.popup()
	pass # Replace with function body.


func _on_select_file_pressed() -> void:
	DisplayServer.file_dialog_show("选择下载目录"," "," ",false,DisplayServer.FILE_DIALOG_MODE_OPEN_DIR,PackedStringArray(),select_end)
	pass # Replace with function body.
func select_end(status:bool,selected_paths:PackedStringArray,selected_filter_index:int):
	if status:
		download_file_path.text=selected_paths[0]
	pass

func _on_change_file_done_pressed() -> void:
	change_download_file_path(download_file_path.text)
	change_download_file_panel.hide()
	pass # Replace with function body.
func read_download_path()->String:
	var path=GlobalConfig.read_config_value("download_file_path","user://")
	if DirAccess.open("user://").dir_exists(path):
		return path
	else:
		GlobalConfig.write_config_value("download_file_path","user://")
		Toast.popup("当前节点集下载目录失效，改为默认目录")
		return "user://"
func change_download_file_path(path:String)->bool:
	if DirAccess.open("user://").dir_exists(path):
		GlobalConfig.write_config_value("download_file_path",path)
		download_path=path
		Toast.popup("更改成功！")
		
		return true
	else:
		Toast.popup("非法目录！")
		return false
				
	


func _on_search_text_text_submitted(new_text: String) -> void:
	
	search()
	pass # Replace with function body.
