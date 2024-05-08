extends HFlowContainer
class_name UrlLabel
var label=preload("res://model/message/tscn/label.tscn")
var texture=preload("res://model/message/tscn/texture.tscn")
@export var label_limit:int=5
@export var text:String
@onready var reg=RegEx.new()
@export var label_settings:LabelSettings
func _ready() -> void:
	
	reload_from_text()
func get_url_from_text():
	reg.compile("\\[(.*?)\\]")
	var from=0
	var res:Array[RegExMatch]=reg.search_all(text)
	
	var normal_text:Array[String]=[]
	var url_text:Array[String]=[]
	for i in res:
		normal_text.append(dum_str(text,from,i.get_start()-1))
		url_text.append(i.get_string(1))
		from=i.get_end()
	if from+1<text.length():
		normal_text.append(dum_str(text,from,text.length()-1))
	return [normal_text,url_text]
func dum_str(text:String,from:int,to:int)->String:
	var temp:String=text.left(to+1)
	temp=temp.right(to+1-from)
	return temp
func add_label(tex:String):
	if tex.begins_with("http://"):
		add_url_img(tex)
		return
	var tex_arr:Array[String]
	var left_tex=tex
	while left_tex.length()>=label_limit:
		tex_arr.append(dum_str(left_tex,0,4))
		left_tex=dum_str(left_tex,5,left_tex.length()-1)
		
	tex_arr.append(left_tex)
	for i in tex_arr:
		var new_label=label.instantiate() as Label
		if label_settings!=null:
			new_label.label_settings=label_settings
		add_child(new_label)
		new_label.text=i
func add_url_img(url:String):
	var imgnew=texture.instantiate()
	add_child(imgnew)
	exe_await_url(imgnew,await UrlGetter.request_url_image(url))

func exe_await_url(node:TextureRect,arr:Array):
	if arr[0]==true:
		node.texture=arr[1]
	else:
		node.queue_free()
func reload_from_text():
	for i in get_children():
		i.queue_free()
	var x=get_url_from_text() as Array
	for i in range(x[1].size()):
		add_label(x[0][i])
		if x[1][i].length()>=4 && x[1][i][0]!="*":
			add_url_img(x[1][i])
		else:
			add_label("@"+x[1][i])
	if x[0].size()>x[1].size():
		add_label(x[0][x[0].size()-1])
		
		pass
