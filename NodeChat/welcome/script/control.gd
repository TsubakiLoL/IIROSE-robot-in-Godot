extends Control
@onready var tab_container: TabContainer = $Control2/TabContainer

var graph_map_tscn=preload("res://NodeChat/graphe/tscn/graphe_map.tscn")
var account_file:String="user://account.txt"

func _ready() -> void:
	IIROSE.debug_message.connect(multi_mes)
	var f=FileAccess.open(account_file,FileAccess.READ)
	if f==null:
		f=FileAccess.open(account_file,FileAccess.WRITE)
		f.close()
	else:
		f.close()
		load_account()
func _process(delta: float) -> void:
	if IIROSE.is_login:
		$Control2/TabContainer/iirose/MarginContainer/Control/flag.modulate=Color.GREEN
	else:
		$Control2/TabContainer/iirose/MarginContainer/Control/flag.modulate=Color.RED
func multi_mes(str:String):
	$loginmes/ScrollContainer/Label.append_text(str+"\n")
func _on_welcome_pressed() -> void:
	tab_container.set_current_tab(0)
	pass # Replace with function body.


func _on_file_pressed() -> void:
	tab_container.set_current_tab(1)
	pass # Replace with function body.


func _on_control_edit_file(path: String) -> void:
	var new_gra=graph_map_tscn.instantiate() as GrapheMap
	add_child(new_gra)
	new_gra.open_state_root(path)
	pass # Replace with function body.


func _on_flag_pressed() -> void:
	$loginmes.show()
	pass # Replace with function body.


func _on_login_pressed() -> void:
	var _name=$Control2/TabContainer/iirose/MarginContainer/Control/name.text
	var p=$Control2/TabContainer/iirose/MarginContainer/Control/password.text
	var r=$Control2/TabContainer/iirose/MarginContainer/Control/room.text
	IIROSE.set_information(_name,p,r)
	IIROSE.start_connect()
	if $Control2/TabContainer/iirose/MarginContainer/Control/shouldsave.button_pressed:
		save_account(_name,p,r)
	pass # Replace with function body.
func load_account():
	var f=FileAccess.open(account_file,FileAccess.READ)
	if f!=null:
		var txt=f.get_as_text()
		var res=JSON.parse_string(txt)
		if res is Array and res.size()==3 and res[0] is String and res[1] is String and res[2] is String:
			$Control2/TabContainer/iirose/MarginContainer/Control/name.text=res[0]
			$Control2/TabContainer/iirose/MarginContainer/Control/password.text=res[1]
			$Control2/TabContainer/iirose/MarginContainer/Control/room.text=res[2]
	pass
func save_account(n:String,p:String,r:String):
	var f=FileAccess.open(account_file,FileAccess.WRITE)
	if f!=null:
		var res=[n,p,r]
		var str=JSON.stringify(res)
		f.store_string(str)
		f.close()
	pass
func _on_iirose_pressed() -> void:
	$Control2/TabContainer.set_current_tab(3)
	pass # Replace with function body.


func _on_gpt_pressed() -> void:
	$Control2/TabContainer.set_current_tab(4)
	var res=ChatGPT.get_key_and_url()
	if res is Array and res.size()==2 and res[0] is String and res[1] is String:
		$Control2/TabContainer/gpt/MarginContainer/Control/key.text=res[0]
		$Control2/TabContainer/gpt/MarginContainer/Control/url.text=res[1]
	pass # Replace with function body.


func _on_gpt_save_pressed() -> void:
	var key=$Control2/TabContainer/gpt/MarginContainer/Control/key.text 
	var url=$Control2/TabContainer/gpt/MarginContainer/Control/url.text
	ChatGPT.set_key_and_url(key,url)
	_on_gpt_pressed()
	pass # Replace with function body.


func _on_move_pressed() -> void:
	IIROSE.move_to_room($Control2/TabContainer/iirose/MarginContainer/Control/roommove.text)
	pass # Replace with function body.


func _on_doc_pressed() -> void:
	$docwin.show()
	pass # Replace with function body.


func _on_plugin_pressed() -> void:
	tab_container.set_current_tab(2)
	pass # Replace with function body.


func _on_online_toggled(toggled_on: bool) -> void:
	if toggled_on:
		%plugin.show()
		%Webfile.is_connect_to_server=true
		%online_num.show()
	else:
		%plugin.hide()
		%Webfile.is_connect_to_server=false
	pass # Replace with function body.


func _on_editor_pressed() -> void:
	OS.shell_open("https://qm.qq.com/q/YYQsyr0zao")
	pass # Replace with function body.


func _on_print_debug_toggled(toggled_on: bool) -> void:
	IIROSE.need_debug_message=toggled_on
	pass # Replace with function body.
