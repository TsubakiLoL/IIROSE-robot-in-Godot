extends TextEdit

class_name NodeChatTextInput
signal node_text_changed(txt:String)

func _on_text_changed() -> void:
	node_text_changed.emit(text)
	pass # Replace with function body.
