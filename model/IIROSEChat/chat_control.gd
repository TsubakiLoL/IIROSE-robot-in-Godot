extends Control
const MESSAGE_MONO = preload("res://model/IIROSEChat/message_mono.tscn")
var mes_array:Array=[]
var max_mes_size:int=30
func add_mes(_name:String,head:String,text:String,is_self:bool=false):
	var is_in_end:bool=is_scroll_in_end()
	var new_mes=MESSAGE_MONO.instantiate()
	if is_self:
		new_mes.side=1
	else:
		new_mes.side=0
	%mes_add_pos.add_child(new_mes)
	new_mes.set_mes(_name,head,text,is_picture_mode())
	mes_array.append(new_mes)
	if mes_array.size()>max_mes_size:
		mes_array[0].queue_free()
		mes_array.pop_front()
	if is_in_end:
		await new_mes.finish
		flow_to_end()
	pass
func is_scroll_in_end()->bool:
	var bar:VScrollBar=%mes_scroll.get_v_scroll_bar()
	return bar.value+bar.page>=bar.max_value
	pass
var last_tween:Tween
func flow_to_end():
	if last_tween!=null:
		last_tween.kill()
		last_tween=null
	last_tween=create_tween()
	
	var bar:VScrollBar=%mes_scroll.get_v_scroll_bar()
	last_tween.tween_property(%mes_scroll,"scroll_vertical",bar.max_value,0.2)
	pass
func clear():
	for i in %mes_add_pos.get_children():
		i.queue_free()
	mes_array.clear()


func _on_line_edit_text_submitted(new_text: String) -> void:
	IIROSE.sent_room_message(new_text)
	%LineEdit.clear()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	IIROSE.sent_room_message(%LineEdit.text)
	%LineEdit.clear()
	pass # Replace with function body.

signal picture_mode_changed(toggled_on:bool)
func _on_check_button_toggled(toggled_on: bool) -> void:
	picture_mode_changed.emit(toggled_on)
	pass # Replace with function body.
#当前是否打开图片显示
func is_picture_mode():
	return %picture_mode.button_pressed
