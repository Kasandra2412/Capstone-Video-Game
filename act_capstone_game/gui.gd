extends Control


@export var menu: NinePatchRect
@export var tutorial: NinePatchRect 
@export var animation_player: AnimationPlayer 
@onready var background: AnimationPlayer = $AnimationPlayer2
@onready var starting_audio: AudioStreamPlayer2D = $AudioStreamPlayer2D



enum STATE {MENU, TUTORIAL}
var ui_state = STATE.MENU #default menu 

func _ready():
	starting_audio.play()

func _process(delta: float) -> void:
	background.play("background")

#swtiching form tutorial to menu
func _input(event):
	if event.is_action_pressed("ui_cancel") and not animation_player.is_playing():
		match ui_state:
			STATE.TUTORIAL:
				ui_state = STATE.MENU
				hide_and_show("tutorial", "menu")

	
	#function to hide and show certain options
func hide_and_show(first:String, second: String):
	animation_player.play("hide_" + first)
	await animation_player.animation_finished
	animation_player.play ("show_" + second)


#hide menu and show tutorial
func _on_tutorial_pressed() -> void:
	ui_state = STATE.TUTORIAL
	hide_and_show("menu", "tutorial")
	
func _on_begin_pressed() -> void:
	animation_player.play("fading_out")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://background_normal.tscn")


func _on_leave_pressed() -> void:
	get_tree().quit()
	

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		match ui_state:
			STATE.TUTORIAL:
				ui_state = STATE.MENU
				hide_and_show("tutorial", "menu")
