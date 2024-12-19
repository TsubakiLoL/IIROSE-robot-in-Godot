extends Control
const PLUGIN_VIEW = preload("res://mod_loader/plugin_view.tscn")

func _ready() -> void:
	update()
	ModLoader.mod_changed.connect(update)

func update():
	for i in %plugin_view_add_pos.get_children():
		i.queue_free()
	var all_plugin_data=ModLoader.get_all_mod_origin_data()
	for i in all_plugin_data.values():
		var new_plugin=PLUGIN_VIEW.instantiate()
		%plugin_view_add_pos.add_child(new_plugin)
		new_plugin.set_data(i)
