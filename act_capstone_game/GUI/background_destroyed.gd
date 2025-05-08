class_name Room_Day3 extends Node2D
@onready var player: Player = $Player
@onready var animation_player: AnimationPlayer = $Player/AnimationPlayer
@onready var fading: AnimationPlayer = $AnimationPlayer

@export var tasks : ToDoListDay3
@onready var task_list: Control = $ToDoList
@onready var dialogue_manager: DialogueManager = $Main/DialogueManager
@export var dialogue_position: DialogueMainDay3
@onready var tv: TvScreen = $TV

@onready var investigation_total = 3
@onready var investigation_found = 0
@onready var investigation_completed = false
var bath_audio = false

var current_investigation_point = ""


var investigated_items = {
	"floor_hole": false,
	"plant_hole": false,
	"bath_hole": false
	}


var tv_watched = false
var area_entered = false
var tv_entered = false
var dialogue_end = false
var anim_done = false
var tv_end = false
var front_door = false

@onready var arrow_player: AnimationPlayer = $Arrows/AnimationPlayer
@onready var arrow_player_2: AnimationPlayer = $Arrows/AnimationPlayer2
@onready var arrow_player_3: AnimationPlayer = $Arrows/AnimationPlayer3

@onready var arrow: Sprite2D = $Arrows/Arrow
@onready var arrow_2: Sprite2D = $Arrows/Arrow2
@onready var arrow_3: Sprite2D = $Arrows/Arrow3


@onready var background: AudioStreamPlayer2D = $Background
@onready var whispers: AudioStreamPlayer2D = $Hidden_area/whispers




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.play()
	fading.play("day_fade_out")
	await fading.animation_finished
	anim_done = true
	arrow_player.play("living_hole")
	arrow_player_2.play("plant_hole")
	arrow_player_3.play("bath_hole")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dialogue_end == false and anim_done == true:
		dialogue_manager.show_messages([
		{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "Ugh, my head is aching..."},
		{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "I have been so tired these days."},
		{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "And the house keeps getting worse and worse everyday. I have no energy to clean."},
		{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "Maybe I should just take it slow for today."}
		], dialogue_position.dialogue_position)
		
		dialogue_end = true
	if investigation_completed == true:
		if tv_entered == true and Input.is_action_just_pressed("click"):
			tv.visible = true
			_on_TV_watched()
	if tv_end==true:
		dialogue_manager.show_messages([
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "What?!"},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "Is that me?!"},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "No!!!"},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "I am right here."},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "How can I be missing?!"},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "This must be some sort of sick prank."},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "I will just tell them."},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "I will tell them I am alive and well."}], dialogue_position.dialogue_position)
		tv_end = false

	if front_door == true:
		_on_front_door()
	
	#leaving the scene
	if area_entered == true and Input.is_action_just_pressed("click"):
		if tv_watched == true:
			_on_leave()
			fading.play("day_fade_in")
			await fading.animation_finished
			get_tree().change_scene_to_file("res://hidden_room1.tscn")
		else:
			animation_player.play("no_nodding_front")
			print ("I still have tasks to do")
	



#investigation code
	if current_investigation_point != "" and Input.is_action_just_pressed("click"):
		investigate_point(current_investigation_point)


func investigate_point(point_id: String) ->void:
	if investigated_items.has(point_id) and not investigated_items[point_id]:
		investigated_items[point_id] = true
		investigation_found +=1
		
		match point_id:
			"floor_hole":
				arrow.visible = false
				dialogue_manager.show_messages([
				{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "What could have happened here?"},
				{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "I should call someone to fix this..."}
				], dialogue_position.dialogue_position)
			"plant_hole":
				arrow_2.visible = false
				dialogue_manager.show_messages([
				{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "Seriously? My plants die, yet this grows from here."}
				], dialogue_position.dialogue_position)
			"bath_hole":
				arrow_3.visible = false
				dialogue_manager.show_messages([
				{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "Oh, this seems like it leads to somewhere."},
				{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "I can hear something from here."},
				{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "I should stay away from now."}
				], dialogue_position.dialogue_position)
				
		if investigation_found >= investigation_total:
			_on_investigation_complete()

#marking investigation
func _on_investigation_complete()->void:
	if not investigation_completed:
		investigation_completed = true
		task_list.mark_task_complete("Investigate")
		print("Investigation Done.")


func _on_TV_watched():
	task_list.mark_task_complete("Watch TV")
	tv_watched = true
	
func _on_front_door():
	task_list.mark_task_complete("Try the 
	front door")

func _on_leave():
	task_list.mark_task_complete("Follow the
	whispers")


#BED AREA -- THIS HAS TO BE DONE LAST. CANT LET THE PLAYER GO TO SLEEP WITHOUT 
#COMPLETING OTHER TASKS 


func _on_hidden_area_body_entered(body: Node2D) -> void:
	area_entered = true 
	whispers.play()
	if body == player:
		current_investigation_point ="bath_hole"


func _on_hidden_area_body_exited(body: Node2D) -> void:
	area_entered = false 
	whispers.stop()
	if body == player and current_investigation_point == "bath_hole":
		current_investigation_point = "" 


func _on_living_hole_body_entered(body: Node2D) -> void:
	if body == player:
		current_investigation_point ="floor_hole" 


func _on_living_hole_body_exited(body: Node2D) -> void:
	if body == player and current_investigation_point == "floor_hole":
		current_investigation_point = ""  


func _on_plant_hole_body_entered(body: Node2D) -> void:
	if body == player:
		current_investigation_point ="plant_hole" 



func _on_plant_hole_body_exited(body: Node2D) -> void:
	if body == player and current_investigation_point == "plant_hole":
		current_investigation_point = "" 
	



func _on_tv_body_entered(body: Node2D) -> void:
	tv_entered = true # Replace with function body.


func _on_tv_body_exited(body: Node2D) -> void:
	tv_entered = false # Replace with function body.


func _on_button_pressed() -> void:
	print("button pressed")
	tv_end = true # Replace with function body.


func _on_front_door_body_entered(body: Node2D) -> void:
	front_door = true
	dialogue_manager.show_messages([
	{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "The door..."},
	{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "It's all barred."},
	{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "I can't leave. I have to find another exit."}], dialogue_position.dialogue_position)


func _on_front_door_body_exited(body: Node2D) -> void:
	dialogue_manager._hide() # Replace with function body.
