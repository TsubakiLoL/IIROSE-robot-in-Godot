extends DrawerContainer
@export var side:int=0
signal finish
func _ready() -> void:
	if side==0:
		%left_tab.hide()
		%right_tab.show()
		%right_head.hide()
		%left_head.show()
		button_model=BUTTON_MODEL.RIGHT
		head_node=%left_head
	else:
		%left_tab.show()
		%right_tab.hide()
		%right_head.show()
		%left_head.hide()
		
		button_model=BUTTON_MODEL.LEFT
		head_node=%right_head
	super._ready()
	change_open()
var head_node:TextureRect
func set_mes(head_url:String,text:String):
	%url_label.text=text
	%url_label.reload_from_text()
	exe_await_url(head_node,await UrlGetter.request_url_image(head_url))
	pass
func exe_await_url(node:TextureRect,arr:Array):
	if arr[0]==true and is_instance_valid(node):
		node.texture=arr[1]


func _on_url_label_finish() -> void:
	finish.emit()
	pass # Replace with function body.
