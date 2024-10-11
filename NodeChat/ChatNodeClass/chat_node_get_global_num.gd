extends ChatNode
class_name ChatNodeGetGlobalNum
var mes:String=""
func _init(root:NodeRoot) -> void:
	super._init(root)
	type=20
	variable_name_array=["mes"]
	variable_type_array=[ChatNode.variable_type.TYPE_STRING]
	variable_type_more=[]
	variable_name_view=["全局变量名"]
	input_port_array=["Dictionary"]
	output_port_array=["Float"]
	init_input()

func process_input(id:String)->bool:
	var data:float
	if root!=null:
		data=root.get_data(id,mes)
	if data!=null:
		sent_data_to_out(data,0,id)
		return true
	else:
		return false
	


func load_from_data(data:Dictionary):
	super.load_from_data(data)
	if data.has("mes"):
		var new_mes=data["mes"]
		mes=new_mes
func export_data(data:Dictionary):
	super.export_data(data)
	data["mes"]=mes
