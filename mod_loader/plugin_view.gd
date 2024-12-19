extends PanelContainer
var origin_data:Dictionary={}

func set_data(mod_origin_data:Dictionary):
	origin_data=mod_origin_data
	var n=mod_origin_data["name"]
	if mod_origin_data.has("name_view"):
		n+=("("+mod_origin_data["name_view"]+")")
	%name.text=n
	if mod_origin_data.has("i"):
		%introduction.text=mod_origin_data["i"]
	else:
		%introduction.text=""
	
	
	pass
