extends Tree
@export var word_set:SingleWord

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_item()
	inst(word_set,get_root())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func inst(word:SingleWord,par:TreeItem):
	if word!=null:
		par.set_text(0,word.name)
		for i in word.next_word_array:
			var new_tree_item=par.create_child()
			inst(i,new_tree_item)
		
