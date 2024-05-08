extends Control
class_name message
var is_move_mouse:bool=false

var mono=preload("res://model/message/tscn/message_mono_with_ani.tscn")
@onready var add_position:VBoxContainer = $ScrollContainer/VBoxContainer

func add_message(name_,head_url,mes):
	var new_mes:mes_with_ani =mono.instantiate() as mes_with_ani
	add_position.add_child(new_mes)
	new_mes.start()
	new_mes.set_name_(name_)
	new_mes.set_message(mes)
	new_mes.set_head_u(head_url)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		is_move_mouse=true
	if event is InputEventMouseButton and !event.pressed:
		is_move_mouse=false
	if event is InputEventMouseMotion and is_move_mouse:
		print("get_strenth"+str(event.get_relative().y))
		$ScrollContainer.get_v_scroll_bar().value-=event.get_relative().y
		




func _on_button_pressed() -> void:
	add_message("111","111","12[http://r.iirose.com/i/22/12/18/3/1136-2T.png#e]11111[http://r.iirose.com/i/22/9/20/22/3210-9C.jpg#e][http://r.iirose.com/i/22/9/21/22/0202-VE.jpg#e] ")
	pass # Replace with function body.
