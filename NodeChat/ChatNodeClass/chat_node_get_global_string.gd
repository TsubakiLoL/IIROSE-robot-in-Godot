extends ChatNode
class_name ChatNodeGetGlobalString
var mes:String=""
func _init(root:NodeRoot) -> void:
	super._init(root)
	type=34
	variable_name_array=["mes"]
	variable_type_array=[ChatNode.variable_type.TYPE_STRING]
	variable_type_more=[]
	variable_name_view=["全局变量名"]
	input_port_array=["Dictionary"]
	output_port_array=["Bool","String"]
	init_input()

func process_input(id:String):
	var data:Array
	if root!=null:
		data=root.get_string(id,mes)
	if data[0] is bool and data[1] is String:
		sent_data_to_out(data[0],0,id)
		sent_data_to_out(data[1],1,id)
	


func load_from_data(data:Dictionary):
	super.load_from_data(data)
	if data.has("mes"):
		var new_mes=data["mes"]
		mes=new_mes
func export_data(data:Dictionary):
	super.export_data(data)
	data["mes"]=mes
