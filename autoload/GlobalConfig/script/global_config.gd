#----------------------
#版权所有：
#	李志鹏
#	新疆大学 计算机科学与技术学院 
#	计算机科学与技术 21-3班
#	毕业设计
#	学号：20211401239
#----------------------



extends Node
var config_file:String="user://config.txt"
func read_config_value(value_name:String,defaule_value):
	var f=FileAccess.open(config_file,FileAccess.READ)
	if f==null:
		f=FileAccess.open(config_file,FileAccess.WRITE)
		f.store_string(JSON.stringify({value_name:defaule_value}))
		return defaule_value
	else:
		var str=f.get_as_text()
		f.close()
		var json=JSON.parse_string(str)
		if json is Dictionary:
			if json.has(value_name):
				var value=json[value_name]
				return value
			else:
				json[value_name]=defaule_value
				f=FileAccess.open(config_file,FileAccess.WRITE)
				f.store_string(JSON.stringify(json))
				f.close()
				return defaule_value
		else:
			f=FileAccess.open(config_file,FileAccess.WRITE)
			f.store_string(JSON.stringify({value_name:defaule_value}))
			f.close()
			return defaule_value
func write_config_value(value_name:String,value):
		var f=FileAccess.open(config_file,FileAccess.READ)
		if f==null:
			f=FileAccess.open(config_file,FileAccess.WRITE)
			f.store_string(JSON.stringify({value_name:value}))
		else:
			var str=f.get_as_text()
			f.close()
			var json=JSON.parse_string(str)
			if json is Dictionary:
				json[value_name]=value
				f=FileAccess.open(config_file,FileAccess.WRITE)
				f.store_string(JSON.stringify(json))
				f.close()
			else:
				f=FileAccess.open(config_file,FileAccess.WRITE)
				f.store_string(JSON.stringify({value_name:value}))

				
	
