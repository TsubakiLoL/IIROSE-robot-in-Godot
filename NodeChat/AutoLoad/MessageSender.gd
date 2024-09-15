extends Node
var is_in_debug:bool=false
signal debug_mes(type:ChatNodeTriger.triger_type,data:Dictionary,mes:String)
##发送消息类型的函数
var message_type_func:Dictionary={
	"iirose_side":func(data:Dictionary):IIROSE.sent_side_message(data["uid"],data["mes"]),
	"iirose_room":func(data:Dictionary):IIROSE.sent_room_message(data["mes"]),
	"iirose_bullet":func(data:Dictionary):IIROSE.sent_bullet_message(data["mes"])
}
##debug模式下生成调试信息的函数
var message_debug_func:Dictionary={
	"iirose_side":func(data:Dictionary):return "向蔷薇花园用户【"+str(data["uid"])+"】发送了消息【"+data["mes"]+"】",
	"iirose_room":func(data:Dictionary):return "向蔷薇花园房间发送了消息【"+data["mes"]+"】",
	"iirose_bullet":func(data:Dictionary):return "向蔷薇花园弹幕发送了消息【"+data["mes"]+"】",
}
##debug模式下判断是否应该在自己面板上显示的函数
var message_debug_is_self_panel_func:Dictionary={
	ChatNodeTriger.triger_type.TYPE_SIDE:func(id:String,data:Dictionary):return data["uid"]==id,
	ChatNodeTriger.triger_type.TYPE_ROOM:func(id:String,data:Dictionary):return true,
	ChatNodeTriger.triger_type.TYPE_BULLET:func(id:String,data:Dictionary):return true,
}
func should_self_panel_show(id:String,data:Dictionary,triger_type:ChatNodeTriger.triger_type)->bool:
	if message_debug_is_self_panel_func.has(triger_type):
		var judge_func:Callable=message_debug_is_self_panel_func[triger_type]
		var result:bool=judge_func.call(id,data)
		return result
	else:
		return false
##信息类型对应的面板triger类型
var message_type_to_debug_triger_type:Dictionary={
	"iirose_side":ChatNodeTriger.triger_type.TYPE_SIDE,
	"iirose_room":ChatNodeTriger.triger_type.TYPE_ROOM,
	"iirose_bullet":ChatNodeTriger.triger_type.TYPE_BULLET,
}
var message_type_text:Dictionary={
	"iirose_side":"蔷薇花园私聊消息",
	"iirose_room":"蔷薇花园房间消息",
	"iirose_bullet":"蔷薇花园弹幕消息"
}

func sent_message(_message_type:String,data:Dictionary):
	if not is_in_debug :
		if message_type_func.has(_message_type):
			var mes_func:Callable=message_type_func[_message_type]
			mes_func.call(data)
		else:
			push_error("信息类型【"+_message_type+"】不存在，消息数据："+str(data))
	else:
		if message_debug_func.has(_message_type):
			var mes_func:Callable=message_debug_func[_message_type]
			debug_mes.emit(_message_type,data,mes_func.call(data))
		else:
			push_error("信息类型【"+_message_type+"】不存在，消息数据："+str(data))
	pass
