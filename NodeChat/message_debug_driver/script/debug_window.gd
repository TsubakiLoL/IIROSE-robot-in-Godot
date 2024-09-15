extends Window

var root_instance:NodeRoot
var driver:MessageDriver
const DEBUG_WINDOW_SIDE_BTN = preload("res://NodeChat/message_debug_driver/tscn/debug_window_side_btn.tscn")
@onready var add_new_side_win: PopupPanel = $add_new_side_win
@onready var side_btn_add_pos: HBoxContainer = $Control/VBoxContainer/HBoxContainer/ScrollContainer/HBoxContainer/side_btn_add_pos
@onready var triger_type_option_btn: OptionButton = $add_new_side_win/HBoxContainer/triger_type_option_btn
@onready var add_name: LineEdit = $add_new_side_win/HBoxContainer/add_name
@onready var add_id: LineEdit = $add_new_side_win/HBoxContainer/add_id
var id_arr:Array[String]=[]
var triger_type_arr:Array[int]
var type_array:Dictionary={
	
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var keys=MessageSender.message_type_to_debug_triger_type.keys()
	for i in keys.size():
		type_array[i]=MessageSender.message_type_to_debug_triger_type[keys[i]]
		triger_type_option_btn.add_item(MessageSender.message_type_text[keys[i]])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_about_to_popup() -> void:
	
	pass # Replace with function body.


func _on_close_requested() -> void:
	$add_new_side_win/HBoxContainer/download_file_path.text=""
	add_new_side_win.hide()
	pass # Replace with function body.


func _on_accept_pressed() -> void:
	
	pass # Replace with function body.


func _on_refuse_pressed() -> void:
	pass # Replace with function body.


func _on_add_side_btn_pressed() -> void:
	add_new_side_win.popup()
	pass # Replace with function body.
