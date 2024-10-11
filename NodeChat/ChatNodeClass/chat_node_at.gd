extends ChatNode
##自动艾特器节点，输入一个字符串变量，输出" [*输入*] "，为字符串类型
class_name ChatNodeAt
func _init(root:NodeRoot) -> void:
	super._init(root)
	type=15
	
	input_port_array=["String"]
	output_port_array=["String"]
	init_input()

func process_input(id:String)->bool:
	if input_port_data[0] is String:
		sent_data_to_out(" [*"+input_port_data[0]+"*] ",0,id)
		return true
	else:
		return false
