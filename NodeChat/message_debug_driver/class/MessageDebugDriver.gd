extends Node
class_name MessageDriver
var now_instance:NodeRoot
func emit_message(id:String,triger_type:int,data:Dictionary):
	if now_instance!=null:
		now_instance.prompt_message(id,triger_type,data)
	
	
	
	pass
