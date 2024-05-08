extends Control
class_name mes_with_ani
@onready var message: mes_mono = $HBoxContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func set_name_(st:String):
	message.set_name_(st)

func set_message(str:String):
	message.set_message(str)

func set_head_u(url):
	message.set_head_u(url)
func set_head(arr:Array):
	message.set_head(arr)
func start():
	animation_player.play("start")
