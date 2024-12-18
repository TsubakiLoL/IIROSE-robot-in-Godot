#----------------------
#版权所有：
#	李志鹏
#	新疆大学 计算机科学与技术学院 
#	计算机科学与技术 21-3班
#	毕业设计
#	学号：20211401239
#----------------------



extends Node
@export var chatgpt:GPTChatRequest
@export var ollama:OllamaChatRequest

var GPT_file:String="user://GPTconfig.txt"
func _ready() -> void:
	chatgpt.gpt_request_completed.connect(comp)
	ollama.request_complete.connect(comp)
	var f=FileAccess.open(GPT_file,FileAccess.READ)
	if f==null:
		f=FileAccess.open(GPT_file,FileAccess.WRITE)
		f.close()
	else:
		load_config()
func comp(gpt_text:String):
	#IIROSE.sent_room_message(gpt_text)
	pass

func ask(mes:String):
	
	chatgpt.gpt_chat_request(mes)
	#ollama.ollama_chat_request(mes)
	pass
func ask_with_name(n:String,mes:String):
	chatgpt.gpt_chat_request_with_name(mes,n)
func set_key_and_url(key:String,url:String):
	if chatgpt!=null:
		chatgpt.api_key=key
		chatgpt.api_url=url
	save_config()
	pass
func get_key_and_url()->Array:
	var res=[]
	if chatgpt!=null:
		res.append(chatgpt.api_key)
		res.append(chatgpt.api_url)

	return res
func save_config():
	var f=FileAccess.open(GPT_file,FileAccess.WRITE)
	if f!=null:
		f.store_string(JSON.stringify(get_key_and_url()))
func load_config():
	var f=FileAccess.open(GPT_file,FileAccess.READ)
	if f!=null:
		var str=f.get_as_text()
		var res=JSON.parse_string(str)
		if res!=null and res is Array and res.size()==2 and res[0] is String and res[1] is String:
			set_key_and_url(res[0],res[1])
