extends PopupPanel
@onready var user_name: LineEdit = $Control/VBoxContainer/HBoxContainer/user_name
@onready var user_p: LineEdit = $Control/VBoxContainer/HBoxContainer2/user_p
@onready var room: LineEdit = $Control/VBoxContainer/HBoxContainer3/room


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	IIROSE.set_information(user_name.text,user_p.text,room.text)
	IIROSE.start_connect()
	pass # Replace with function body.
