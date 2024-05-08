extends ChatNode
class_name ChatNodeSentBulletMessageMultiInput
func _init(root:NodeRoot) -> void:
	super._init(root)
	type=16
	
	input_port_array=["Bool","String"]
	output_port_array=[]
	init_input()

func process_input(id:String):
	if input_port_data[0] is bool and input_port_data[1] is String and input_port_data[0]:
		IIROSE.sent_bullet_message(input_port_data[1])


