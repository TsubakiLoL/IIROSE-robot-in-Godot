extends ChatNode
class_name ChatNodeGPTRequestWithName
func _init(root:NodeRoot) -> void:
	super._init(root)
	type=39
	input_port_array=["Bool","String","String"]
	output_port_array=[]
	init_input()

func process_input(id:String)->bool:
	if input_port_data[0] is bool and input_port_data[0] and input_port_data[1] is String and input_port_data[2] is String:
		ChatGPT.ask_with_name(input_port_data[1],input_port_data[2])
		return true
	else:
		return false
