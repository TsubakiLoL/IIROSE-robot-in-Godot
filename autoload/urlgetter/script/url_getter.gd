extends Node
var url_mono=preload("res://autoload/urlgetter/tscn/head_url.tscn")
var url_dictionary:Dictionary={}
func request_url_image(url:String)->Array:
	var split:PackedStringArray=url.split("#")

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
			var z
			#z=i.load_jpg_from_buffer(data)
			#if z!=OK:
				#z=i.load_png_from_buffer(data)
			#if z!=OK:
				#z=i.load_bmp_from_buffer(data)
			#if z!=OK:
				#z=i.load_ktx_from_buffer(data)
			#if z!=OK:
				#z=i.load_svg_from_buffer(data)
			if is_format("jpg",data):
				z=i.load_jpg_from_buffer(data)
			elif is_format("png",data):
				z=i.load_png_from_buffer(data)
			elif is_format("bmp",data):
				z=i.load_bmp_from_buffer(data)
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
var head_and_back_dictionary:Dictionary={
	#FF D8 FF E0
	#FF D9
	"jpg":[[0xFF,0xD8,0xFF,0xE0],[0xFF,0xD9]],
	#文件头：89 50 4E 47 0D 0A 1A 0A
	#文件尾：49 45 4E 44 AE 42 60 82
	"png":[[0x89,0x50,0x4E,0x47,0x0D,0x0A,0x1A,0x0A],[0x49,0x45,0x4E,0x44,0xAE,0x42,0x60,0x82]],
	#42 4D
	"bmp":[[0x42,0x4D],[]]
}

func is_format(n:String,file_data:PackedByteArray)->bool:
	if head_and_back_dictionary.has(n):
		var data=head_and_back_dictionary[n]
		var head:Array=data[0]
		var head_size:int=head.size()
		var back:Array=data[1]
		var back_size:int=back.size()
		
		var data_size:int=file_data.size()
		if data_size<head_size+back_size:
			return false
		var is_f:bool=true
		for i in head_size:
			if head[i]!=file_data[i]:
				is_f=false
		for i in back_size:
			if back[back_size-i-1]!=file_data[data_size-i-1]:
				is_f=false
		return is_f
	else:
		return false
