extends ChatNode
class_name ChatNodeTime
func _init(root:NodeRoot) -> void:
	super._init(root)
	type=31
	input_port_array=["Dictionary"]
	output_port_array=["Float"]
	init_input()

func process_input(id:String):
	sent_data_to_out(Time.get_unix_time_from_system(),0,id)
	

