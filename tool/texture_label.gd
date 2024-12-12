#----------------------
#版权所有：
#	李志鹏
#	新疆大学 计算机科学与技术学院 
#	计算机科学与技术 21-3班
#	毕业设计
#	学号：20211401239
#----------------------



extends  RichTextLabel
class_name TextureLabel
#获取图片在大小限制下的最小大小
static func get_texture_size_in_size_limit(texture:Texture2D,limit_size:Vector2)->Vector2:
	var texture_size:Vector2=texture.get_size()
	
	var multi:Vector2=texture_size/limit_size
	var max_multi=max(multi.x,multi.y)
	return texture_size/max_multi
@export var origin_text:String=""
func set_text_label(txt:String):
	origin_text=txt
#url正则匹配
@onready var url_regex:RegEx=RegEx.create_from_string("\\[(?<url>(http|https|ftp):\\/\\/[^\\]]+)\\]")


func reload_from_origin_text():
	var res=regex_match(origin_text)
	var str_arr=res[0]
	var url_arr=res[1]
	clear()
	var index:int=0
	while index<str_arr.size() || index<url_arr.size():
		if index<str_arr.size():
			append_text(str_arr[index])
		if index<url_arr.size():
			add_image(preload("res://icon.svg"))
		
		index+=1

#获取随机的key来执行异步获取图片的任务
func get_unique_key_from_time(str:String,rand:float)->String:
	var md5_str:String=str.md5_text()
	var rand_str:String=str(rand).md5_text()
	return md5_str+rand_str
#使用regex来匹配字符串，并给出切分后的字符串[[字符串需略],[解析序列],]
func regex_match(str:String)->Array:
	var s:Array[RegExMatch]=url_regex.search_all(str)
	var result_str_part:Array[String]
	var result_url_part:Array[String]	
	if s.size()==0:
		result_str_part.append(str)
		return [result_str_part,result_url_part]
	var before_str_start:int=0
	
	for i in s:
		result_str_part.append(split_str(str,before_str_start,i.get_start()))
		before_str_start=i.get_end()
		result_url_part.append(i.get_string("url"))
	if before_str_start<str.length():
		result_str_part.append(split_str(str,before_str_start,str.length()))
		
	
	return [result_str_part,result_url_part]

func _ready() -> void:
	#var s=url_regex.search_all("daawd[ddwadaw]ddaa[dawwddw]eesqeqe[https://ssfe]")
	#var str_arr:Array=[0,]
	#for i in s:
		#print("start:"+str(i.get_start()))
		#print("end:"+str(i.get_end()))
		#print(i.get_string("url"))
	origin_text="daawd[ddwadaw]ddaa[dawwddw]eesqeqe[https://ssfe]12434[https://ssfe][https://ssfe]"
	reload_from_origin_text()
	pass	

	print(regex_match("daawd[ddwadaw]ddaa[dawwddw]eesqeqe[https://ssfe]12434[https://ssfe][https://ssfe]a"))
static func split_str(str:String,from:int,to:int):
	var right:String=str.right(str.length()-from)
	var left=right.left(to-from)
	return left
