extends Node
var url_mono=preload("res://autoload/urlgetter/tscn/head_url.tscn")
var url_dictionary:Dictionary={}
func request_url_image(url:String)->Array:
	if url_dictionary.has(url):
		return [true,url_dictionary[url]]
	else:
		var new_req=url_mono.instantiate() as self_url
		add_child(new_req)
		new_req.request(url)
		await new_req.request_completed
		var is_success=new_req.is_success
		var data=new_req.get_data()
		new_req.queue_free()
		if is_success:
			var i=Image.new()
			var z=i.load_jpg_from_buffer(data)
			if z!=OK:
				z=i.load_png_from_buffer(data)
			if z!=OK:
				z=i.load_bmp_from_buffer(data)
			if z!=OK:
				z=i.load_ktx_from_buffer(data)
			if z!=OK:
				z=i.load_svg_from_buffer(data)
			if z==OK:
				var x=ImageTexture.create_from_image(i)
				url_dictionary[url]=x
				return [true,x]
			else:
				push_warning("不支持的url格式")
				return [false,null]
				
		else:
			push_warning("url加载时遇到错误")
			return [false,null]
			
	
	pass
	
