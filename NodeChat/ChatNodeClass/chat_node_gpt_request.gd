extends ChatNode
class_name ChatNodeGPTRequest
func _init(root:NodeRoot) -> void:
	super._init(root)
	type=38
	input_port_array=["Bool","String"]
	output_port_array=[]
	init_input()

func process_input(id:String)->bool:
	if input_port_data[0] is bool and input_port_data[0] and input_port_data[1] is String:
		ChatGPT.ask(input_port_data[1])
		return true
	else:
		return false
