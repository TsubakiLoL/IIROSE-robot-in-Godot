extends PanelContainer


func set_text(str:String):
	$Label.text=str


func _on_timer_timeout() -> void:
	self.queue_free()
	pass # Replace with function body.
