extends HBoxContainer
class_name mes_mono
@onready var head: TextureRect = $Control/head
@onready var _name: Label = $Control/name
@onready var message_: UrlRich = $Control2/message
var urltscn=preload("res://autoload/urlgetter/tscn/head_url.tscn")
func set_name_(st:String):
	_name.text=st

func set_message(str:String):
	message_.text_in=str
	message_.reload_from_text()

func set_head_u(url):
	set_head(await UrlGetter.request_url_image(url))
func set_head(arr:Array):
	if arr.size()==2:
		if arr[0]==true:
			head.texture=arr[1]
			
		else:
			return
	else:
		return
