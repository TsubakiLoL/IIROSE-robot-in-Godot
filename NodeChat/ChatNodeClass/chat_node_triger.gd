extends ChatNode
class_name ChatNodeTriger

static func get_triger_type_name(type:triger_type)->String:
	
	if triger_type_name.has(type):
		return str(triger_type_name[type])
	else:
		return "未命名触发器类型"+str(type)
	pass
var triget_t:triger_type=triger_type.TYPE_BULLET
func _init(root:NodeRoot) -> void:
	super._init(root)
	type=1
	variable_name_array=["triget_t"]
	variable_type_array=[ChatNode.variable_type.TYPE_SELECT]
	var triger_type_arr=[]
	var triger_type_name_arr=[]
	for i in triger_type.values():
		triger_type_arr.append(i)
		if triger_type_name.has(i):
			triger_type_name_arr.append(str(triger_type_name[i]))
		else:
			triger_type_name_arr.append("未命名触发器类型："+str(i))
	#variable_type_more=[[[0,1,2,3,4],["弹幕","房间","私聊","进入状态","退出状态"]]]
	variable_type_more=[[triger_type_arr,triger_type_name_arr]]
	variable_name_view=["模式"]
	input_port_array=["StateWithTriger"]
	output_port_array=["Dictionary"]
	init_input()

func process_input(id:String)->bool:
	var data=input_port_data[0]
	if data is Array and data.size()==2:
		var t=data[0]
		if t==triget_t and data[1] is Dictionary:
			sent_data_to_out(data[1],0,id)
			return true
	return false
	pass

func load_from_data(data:Dictionary):
	super.load_from_data(data)
	if data.has("triger_t"):
		var new_triger_t=data["triger_t"]
		#print(new_triger_t)
		if int(new_triger_t) in triger_type.values():
			triget_t=int(new_triger_t)
func export_data(data:Dictionary):
	super.export_data(data)
	data["triger_t"]=triget_t
