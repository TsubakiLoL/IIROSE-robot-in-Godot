extends ChatNode
class_name ChatNodeSentRoomMessage
func _init(root:NodeRoot) -> void:
	super._init(root)
	type=4
	input_port_array=["String"]
	output_port_array=[]
	init_input()

func process_input(id:String):
	if input_port_data[0] is String:
		MessageSender.sent_message("iirose_room",{"mes":input_port_data[0]})


