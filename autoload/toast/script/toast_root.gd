extends CanvasLayer

@onready var toast_tscn=preload("res://autoload/toast/tscn/toast.tscn")
# Called when the node enters the scene tree for the first time.
func popup(str:String):
	var new_toast=toast_tscn.instantiate()
	
	
	$pos/VBoxContainer.add_child(new_toast)
	new_toast.set_text(str)
	pass
