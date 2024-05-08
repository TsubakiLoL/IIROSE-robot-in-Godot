extends RichTextLabel
class_name UrlRich
const ICON = preload("res://icon.svg")
@export var label_limit:int=5
@export var text_in:String
@onready var reg=RegEx.new()
@export var label_settings:LabelSettings
func _ready() -> void:
	
	reload_from_text()
func get_url_from_text():
	reg.compile("\\[(.*?)\\]")
	var from=0
	var res:Array[RegExMatch]=reg.search_all(text_in)
	
	var normal_text:Array[String]=[]
	var url_text:Array[String]=[]
	for i in res:
		normal_text.append(dum_str(text_in,from,i.get_start()-1))
		url_text.append(i.get_string(1))
		from=i.get_end()
	if from+1<text_in.length():
		normal_text.append(dum_str(text_in,from,text_in.length()-1))
	return [normal_text,url_text]
func dum_str(text:String,from:int,to:int)->String:
	var temp:String=text.left(to+1)
	temp=temp.right(to+1-from)
	return temp
func add_label(tex:String):
	append_text(tex)
func add_url_img(url:String,key):
	add_image(ICON,0,0,Color(1,1,1,1),5,Rect2(0,0,0,0),key)
	print("request url :"+url)
	image_callback(key,await UrlGetter.request_url_image(url))
func image_callback(key:int,data:Array):
	if data[0]==true:
		update_image(key,1,data[1],0.5,0.5,Color(1,1,1,1),14,Rect2(0,0,1,1),true,"",true)
	else:
		return
	
	pass
func reload_from_text():
	if text_in.begins_with("http://"):
		add_url_img(text_in,1)
		return
	var x=get_url_from_text() as Array
	for i in range(x[1].size()):
		add_label(x[0][i])
		if x[1][i].length()>=4 && x[1][i][0]!="*":
			add_url_img(x[1][i],i)
		else:
			add_label("@"+x[1][i])
	if x[0].size()>x[1].size():
		add_label(x[0][x[0].size()-1])
		
		pass
