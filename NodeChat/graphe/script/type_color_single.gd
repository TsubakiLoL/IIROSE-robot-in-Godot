extends HBoxContainer
class_name TypeColorSingle
func set_information(color:Color,text:String):
	$TextureRect.modulate=color
	$Label.text=text
