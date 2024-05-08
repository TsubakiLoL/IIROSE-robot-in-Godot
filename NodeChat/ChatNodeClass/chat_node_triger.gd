extends ChatNode
class_name ChatNodeTriger
enum triger_type{
	TYPE_BULLET=0,
	TYPE_ROOM=1,
	TYPE_SIDE=2,
	TYPE_ENTER=3,
	TYPE_EXIT=4
}
var triget_t:triger_type=triger_type.TYPE_BULLET
func _init(root:NodeRoot) -> void:
	super._init(root)
	type=1
	variable_name_array=["triget_t"]
	variable_type_array=[ChatNode.variable_type.TYPE_SELECT]
	
	variable_type_more=[[[0,1,2,3,4],["弹幕","房间","私聊","进入状态","退出状态"]]]
	variable_name_view=["模式"]
	input_port_array=["StateWithTriger"]
	output_port_array=["Dictionary"]
	init_input()

func process_input(id:String):
	var data=input_port_data[0]
	if data is Array and data.size()==2:
		var t=data[0]
		print("消息类型",t,"触发器类型",triget_t)
		if t==triget_t and data[1] is Dictionary:
			sent_data_to_out(data[1],0,id)
	pass

func load_from_data(data:Dictionary):
	super.load_from_data(data)
	if data.has("triger_t"):
		print("加载触发器类型")
		var new_triger_t=data["triger_t"]
		print(new_triger_t)
		if int(new_triger_t) in triger_type.values():
			triget_t=int(new_triger_t)
			print("加载成功")
func export_data(data:Dictionary):
	super.export_data(data)
	data["triger_t"]=triget_t
