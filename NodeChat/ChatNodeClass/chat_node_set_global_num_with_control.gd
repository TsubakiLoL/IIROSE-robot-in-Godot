extends ChatNode
class_name ChatNodeSetGlobalNumWithControl

var num_name:String=""
func _init(root:NodeRoot) -> void:
	super._init(root)
	type=19
	input_port_array=["Bool","Float"]
	variable_name_array=["num_name"]
	variable_type_array=[ChatNode.variable_type.TYPE_STRING]
	variable_type_more=[]
	variable_name_view=["全局变量名"]
	output_port_array=[]
	init_input()
func process_input(id:String)->bool:
	if input_port_data[0] is bool and input_port_data[1] is float  and input_port_data[0]and root!=null:
		root.set_data(id,num_name,input_port_data[1])
		return true
	else:
		return false
	pass


func load_from_data(data:Dictionary):
	super.load_from_data(data)
	if data.has("num_name"):
		var new_mes=data["num_name"]
		num_name=new_mes

func export_data(data:Dictionary):
	super.export_data(data)
	data["num_name"]=num_name
