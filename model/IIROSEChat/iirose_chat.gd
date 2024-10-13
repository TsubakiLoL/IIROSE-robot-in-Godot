extends Window

func _ready() -> void:
	set_process(false)
func _on_about_to_popup() -> void:
	set_process(true)
	%ChatControl.clear()
	if not IIROSE.room_message_received.is_connected(_on_room_mes_receive):
		IIROSE.room_message_received.connect(_on_room_mes_receive)
	for i in IIROSE.room_message_cache:
		var is_self=false
		if i["name"]==IIROSE.get_self_name():
			is_self=true
		%ChatControl.add_mes(i["head"],i["message"],is_self)
	pass # Replace with function body.


func _on_room_mes_receive(arr:Array):
	for i in arr:
		var is_self=false
		if i["name"]==IIROSE.get_self_name():
			is_self=true
		%ChatControl.add_mes(i["head"],i["message"],is_self)


func _on_close_requested() -> void:
	set_process(false)
	if IIROSE.room_message_received.is_connected(_on_room_mes_receive):
		IIROSE.room_message_received.disconnect(_on_room_mes_receive)
	hide()
	pass # Replace with function body.
