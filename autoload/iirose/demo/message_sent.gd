
#----------------------
#版权所有：
#	李志鹏
#	新疆大学 计算机科学与技术学院 
#	计算机科学与技术 21-3班
#	毕业设计
#	学号：20211401239
#----------------------


extends PopupPanel
var f1:Function
var f2:Function
var f3:Function
@onready var chart_1: Chart = $"Control/TabContainer/股票/VBoxContainer/Chart1"
@onready var chart_2: Chart = $"Control/TabContainer/股票/VBoxContainer/Chart2"
@onready var chart_3: Chart = $"Control/TabContainer/股票/VBoxContainer/Chart3"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	IIROSE.stock_update.connect(stock_update)
	# Let's create our @x values
	var x: Array = ArrayOperations.multiply_float(range(-10, 11, 1), 0.5)
	
	# And our y values. It can be an n-size array of arrays.
	# NOTE: `x.size() == y.size()` or `x.size() == y[n].size()`
	
	# Let's customize the chart properties, which specify how the chart
	# should look, plus some additional elements like labels, the scale, etc...
	var cp: ChartProperties = ChartProperties.new()
	cp.colors.frame = Color("#161a1d")
	cp.colors.background = Color.TRANSPARENT
	cp.colors.grid = Color("#283442")
	cp.colors.ticks = Color("#283442")
	cp.colors.text = Color.WHITE_SMOKE
	cp.draw_bounding_box = false
	cp.show_legend = true
	cp.title = "蔷薇股市走势"
	cp.x_label = "时间"
	cp.y_label = "值"
	cp.x_scale = 5
	cp.y_scale = 10
	cp.interactive = true # false by default, it allows the chart to create a tooltip to show point values
	# and interecept clicks on the plot
	
	# Let's add values to our functions
	f1 = Function.new(
		[0], [0], "单价", # This will create a function with x and y values taken by the Arrays 
						# we have created previously. This function will also be named "Pressure"
						# as it contains 'pressure' values.
						# If set, the name of a function will be used both in the Legend
						# (if enabled thourgh ChartProperties) and on the Tooltip (if enabled).
		# Let's also provide a dictionary of configuration parameters for this specific function.
		{ 
			color = Color("#36a2eb"), 		# The color associated to this function
			marker = Function.Marker.NONE, 	# The marker that will be displayed for each drawn point (x,y)
											# since it is `NONE`, no marker will be shown.
			type = Function.Type.AREA, 		# This defines what kind of plotting will be used, 
											# in this case it will be an Area Chart.
			interpolation = Function.Interpolation.STAIR	# Interpolation mode, only used for 
															# Line Charts and Area Charts.
		}
	)
	f2 = Function.new([0], [0], "总股数", { color = Color("#ff6384"), marker = Function.Marker.CROSS })
	f3 = Function.new([0], [0], "总值", { color = Color.GREEN, marker = Function.Marker.TRIANGLE })
	
	# Now let's plot our data
	chart_1.plot([f1], cp)
	chart_2.plot([f2], cp)
	chart_3.plot([f3], cp)
	# Uncommenting this line will show how real time data plotting works
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	IIROSE.sent_room_message($"Control/TabContainer/房间/VBoxContainer/TextEdit".text)
	pass # Replace with function body.


func _on_bullet_pressed() -> void:
	IIROSE.sent_bullet_message($"Control/TabContainer/弹幕/VBoxContainer/TextEdit".text)
	pass # Replace with function body.


func _on_side_pressed() -> void:
	IIROSE.sent_side_message($"Control/TabContainer/私聊/VBoxContainer/HBoxContainer/TextEdit".text,$"Control/TabContainer/私聊/VBoxContainer/TextEdit".text)
	pass # Replace with function body.
func stock_update():
	var mesc=Time.get_ticks_msec()
	f1.add_point(mesc,IIROSE.stock_message[2])
	f2.add_point(mesc,IIROSE.stock_message[0])
	f3.add_point(mesc,IIROSE.stock_message[1])
	chart_1.queue_redraw()
	chart_2.queue_redraw()
	chart_3.queue_redraw()
	pass


func _on_tab_container_tab_changed(tab: int) -> void:
	if tab==3:
		size.y=900
	else:
		size.y=300
	pass # Replace with function body.


func _on_cmd_pressed() -> void:
	IIROSE.sent_str($"Control/TabContainer/指令/VBoxContainer/TextEdit".text)
	pass # Replace with function body.
