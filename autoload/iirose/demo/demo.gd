extends Control
var white_array:Array[String]=[]
var load_file="user://white_array.txt"
func _ready() -> void:
	load_white_array()
	OS.shell_open(OS.get_user_data_dir())
	IIROSE.room_message_received.connect(welcome)
	IIROSE.side_message_received.connect(zanme)
	IIROSE.bullet_message_received.connect(zanme)
	IIROSE.room_message_received.connect(zanme)
	pass
	
# [*雪村千绘莉*]  
func welcome(mes:Array):
	#print(IIROSE.uid_list)
	for i in mes:
		if i["message"]=="\'1" and i["name"]!=IIROSE.get_self_name():
			IIROSE.sent_room_message("欢迎"+" [*"+i["name"]+"*]  "+"的到来！")
		elif  i["message"]=="\'3" and  i["name"]!=IIROSE.get_self_name():
				IIROSE.sent_room_message(" [*"+i["name"]+"*]  "+"一路顺风~")
	pass

func zanme(mes:Array):
	for i in mes:
		if i["message"]=="赞我" and i["name"]!=IIROSE.get_self_name():
			if add_white_array(i["uid"]):
				IIROSE.sent_side_message(i["uid"],"已经加入了哦~")
			IIROSE.sent_tu(i["uid"])
func _on_button_pressed() -> void:
	for i in white_array:
		IIROSE.sent_tu(i)
	
	pass # Replace with function body.
func load_white_array():
	var f=FileAccess.open(load_file,FileAccess.READ)
	if f!=null:
		var line=f.get_line()
		while line!=null and line!="":
			white_array.append(line)
			line=f.get_line()
	else:
		f=FileAccess.open(load_file,FileAccess.WRITE)
		f.close()
	
	pass
func write_white_array():
	var f=FileAccess.open(load_file,FileAccess.WRITE)
	if f!=null:
		for i in white_array:
			f.store_line(i)
	
	
	pass

func add_white_array(new:String)->bool:
	print("加入白名单："+new)
	if new not in white_array:
		white_array.append(new)
		write_white_array()
		return true
	else:
		return false
