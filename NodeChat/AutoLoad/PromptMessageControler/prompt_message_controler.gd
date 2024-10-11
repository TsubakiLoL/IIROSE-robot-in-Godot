extends Node



func prompt(id:String,triger_type:ChatNodeTriger.triger_type,mes:Dictionary):
	
	for  i in triget_array:
		if i!=null:
			i.callv([id,triger_type,mes])
	
	
	pass
#链接的函数
var triget_array:Array[Callable]=[]
#链接
func link(cal:Callable):
	if cal not in triget_array:
		triget_array.append(cal)
#是否链接
func is_linked(cal:Callable)->bool:
	return cal in triget_array
#取消链接
func dislink(cal:Callable):
	if cal in triget_array:
		triget_array.pop_at(triget_array.find(cal))
