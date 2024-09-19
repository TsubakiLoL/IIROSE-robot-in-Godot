extends Window

var root_instance:NodeRoot
var driver:MessageDriver
const DEBUG_WINDOW_SIDE_BTN = preload("res://NodeChat/message_debug_driver/tscn/debug_window_side_btn.tscn")

@onready var add_new_side_win: PopupPanel = $add_new_side_win
@onready var side_btn_add_pos: HBoxContainer = $Control/VBoxContainer/HBoxContainer/ScrollContainer/HBoxContainer/side_btn_add_pos
@onready var triger_type_option_btn: OptionButton = $add_new_side_win/HBoxContainer/triger_type_option_btn
@onready var add_id: LineEdit = $add_new_side_win/HBoxContainer/add_id
@onready var graph_add_pos: PanelContainer = $Control/VBoxContainer/HBoxContainer2/VSplitContainer/graph_add_pos
@onready var tree: Tree = $Control/VBoxContainer/HBoxContainer2/VSplitContainer/Panel/HSplitContainer/Tree

var graph:DebugGraph
var tree_cache:Dictionary={}


const DEBUG_GRAPH = preload("res://NodeChat/message_debug_driver/tscn/debug_graph.tscn")

var id_arr:Array[String]=[]
var triger_type_arr:Array[int]
var type_array:Dictionary={
	
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var keys=MessageSender.message_type_to_debug_triger_type.keys()
	for i in keys.size():
		type_array[i]=MessageSender.message_type_to_debug_triger_type[keys[i]]
		triger_type_option_btn.add_item(MessageSender.message_type_text[keys[i]])
	
	pass # Replace with function body.


func instance_graph():
	if graph!=null:
		graph.queue_free()
	var newgraph=DEBUG_GRAPH.instantiate() as DebugGraph
	graph_add_pos.add_child(newgraph)
	newgraph.reload_from_state_r(root_instance)
	graph=newgraph
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_about_to_popup() -> void:
	instance_graph()
	root_instance.prompt_message_debug("text",ChatNodeTriger.triger_type.TYPE_ROOM,{
		"uid":"text",
		"message":"这是一条测试",
		"name":"测试"
	})
	root_instance.prompt_message_debug("text2",ChatNodeTriger.triger_type.TYPE_ROOM,{
		"uid":"text2",
		"message":"这是一条测试2",
		"name":"测试2"
	})
	print(str(root_instance.debug_cache))
	create_tree_from_frame(root_instance.debug_cache)
	pass # Replace with function body.
func create_tree_from_frame(debug_cache:Array):
	tree.clear()
	tree_cache.clear()
	tree.create_item()
	for i in root_instance.debug_cache:
		var item=tree.create_item()
		tree_cache[item]=i["frame"][0]
		item.set_text(0,i.id)
		for j in i.frame:
			var it=item.create_child()
			tree_cache[it]=j
			it.set_text(0,ChatNodeGraph.node_name[j.type]+str(j.id))
			var input=it.create_child()
			input.set_text(0,"输入")
			tree_cache[input]=j
			var output=it.create_child()
			output.set_text(0,"输出")
			tree_cache[output]=j
			for k in j.input_data_arr.size():
				var m=input.create_child()
				m.set_text(0,"端口"+str(k)+":"+str(j.input_data_arr[k]))
				m.set_custom_color(0,ChatNodeGraph.type_color[j.input_data_type[k]])
				tree_cache[m]=j
				
			for k in j.output_data_arr.size():
				var m=output.create_child()
				m.set_text(0,"端口"+str(k)+":"+str(j.output_data_arr[k]))
				m.set_custom_color(0,ChatNodeGraph.type_color[j.output_data_type[k]])
				tree_cache[m]=j
			it.set_collapsed(true)
	pass

func _on_close_requested() -> void:
	add_new_side_win.hide()
	if graph!=null:
		graph.queue_free()
	if root_instance!=null:
		root_instance.delete()
	hide()
	pass # Replace with function body.


func _on_accept_pressed() -> void:
	
	pass # Replace with function body.


func _on_refuse_pressed() -> void:
	pass # Replace with function body.


func _on_add_side_btn_pressed() -> void:
	add_new_side_win.popup()
	pass # Replace with function body.


func _on_tree_item_selected() -> void:
	var item=tree.get_selected()
	if tree_cache.has(item):
		graph.focus_id(tree_cache[item].id)
	pass # Replace with function body.
