extends Control
class_name UrlRichLabel
@export_multiline var text:String="":
	set(val):
		text=val
var item_arr:Array=[]

func get_item_arr_from_text():
	
	
	
	pass
func _ready() -> void:
	UrlGetter.request_url_image("http://i03piccdn.sogoucdn.com/efb0086bf9d672a3")
	pass
	
