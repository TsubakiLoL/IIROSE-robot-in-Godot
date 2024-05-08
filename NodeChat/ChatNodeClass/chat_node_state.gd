extends ChatNode
class_name ChatNodeState

enum triger_type{
	TYPE_BULLET=0,
	TYPE_ROOM=1,
	TYPE_SIDE=2,
	TYPE_ENTER=3,
	TYPE_EXIT=4
}
var is_init:bool=false:
	set(val):
		if not is_init and val:
			print("设置状态：",val)
			root.set_init_state(self)
			is_init=val
		if is_init and not val:
			print("设置状态：",val)
			is_init=val
func _init(root:NodeRoot) -> void:
	super._init(root)
	type=0
	variable_name_array=["is_init"]
	variable_type_array=[ChatNode.variable_type.TYPE_BOOL]
	variable_type_more=[]
	variable_name_view=["进入状态"]
	input_port_array=["ChangeState"]
	output_port_array=["StateWithTriger"]
	init_input()

func process_input(id:String):
	if input_port_data[0] is bool and input_port_data[0]:
		if root!=null:
			root.change_state(id,self)
			pass	
	pass
	

	
	
	

func bullet_message(mes:Dictionary):
	if mes.has("uid"):
		sent_data_to_out([triger_type.TYPE_BULLET,mes],0,mes["uid"])
func room_message(mes:Dictionary):
	print("状态收到房间消息",mes)
	if mes.has("uid"):
		print("存在uid")
		sent_data_to_out([triger_type.TYPE_ROOM,mes],0,mes["uid"])
func side_message(mes:Dictionary):
	if mes.has("uid"):
		sent_data_to_out([triger_type.TYPE_SIDE,mes],0,mes["uid"])

func enter_state(id:String):
	sent_data_to_out([triger_type.TYPE_ENTER,{}],0,id)


func exit_state(id:String):
	sent_data_to_out([triger_type.TYPE_EXIT,{}],0,id)
