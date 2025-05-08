class_name Room_Day2 extends Node2D
@onready var player: Player = $Player
@onready var animation_player: AnimationPlayer = $Player/AnimationPlayer
@onready var fading: AnimationPlayer = $AnimationPlayer
@onready var eating_count: int = 0
@onready var plant_count = 0
@onready var plants: Node2D = $Plants
@onready var task_list: Control = $ToDoList
@onready var dialogue_manager: DialogueManager = $Main/DialogueManager
@onready var computer_2: ComputerDay2 = $Computer2
@onready var making_bed_area_entered = false
var bed_made = false
var phone_answered = false

@export var tasks: ToDoListDay2
@export var message_click: Message
@onready var message_screen: Sprite2D = $Computer2/MessageScreen


@onready var next_label: Label = $Main/NextLabel

@onready var computer_used:bool = false

#investigation variables

@onready var investigation_total = 6
@onready var investigation_found = 0
@onready var investigation_completed = false
var current_investigation_point = ""

var investigated_items = {
	"moved_chair": false,
	"broken_desk": false,
	"wilted_plants": false,
	"leaking_fridge": false,
	"torn_changer": false,
	"torn_bathroom_rug": false
	}

@export var dialogue_position: DialogueMain


@export var button_pressed: ComputerDay2

@onready var made_bed: TileMapLayer = $BedMade
@onready var unmade_bed: TileMapLayer = $UnmadeBed


#AUDIOS 
@onready var eating_audio: AudioStreamPlayer2D =$Eating
@onready var eating_audio_activate : AudioStream = preload("res://audios/eating-sound-effect-36186.mp3")
@onready var background: AudioStreamPlayer2D = $Background
@onready var message: AudioStreamPlayer2D = $message
var message_sound = false


var bed_entered = false
var fridge_entered = false
var plant_entered = false
var comp_entered = false



@onready var arrow_animations: AnimationPlayer = $Arrows/Arrow_animations
@onready var arrow_animations_6: AnimationPlayer = $Arrows/Arrow_animations_6
@onready var arrow_animations_4: AnimationPlayer = $Arrows/Arrow_animations_4
@onready var arrow_animations_3: AnimationPlayer = $Arrows/Arrow_animations_3
@onready var arrow_animations_2: AnimationPlayer = $Arrows/Arrow_animations_2
@onready var arrow_animations_5: AnimationPlayer = $Arrows/Arrow_animations_5

@onready var arrow: Sprite2D = $Arrows/Arrow #changer
@onready var arrow_7: Sprite2D = $Arrows/Arrow7 #plant
@onready var arrow_3: Sprite2D = $Arrows/Arrow3 #chair
@onready var arrow_5: Sprite2D = $Arrows/Arrow5 #table
@onready var arrow_6: Sprite2D = $Arrows/Arrow6 #rug
@onready var arrow_4: Sprite2D = $Arrows/Arrow4 #fridge

@onready var day_label: Label = $DayLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.play()
	unmade_bed.visible = true
	made_bed.visible = false
	fading.play("day_fade_out")
	await fading.animation_finished
	

	arrow_animations.play("arrow3_moving")
	arrow_animations_2.play("arrow_moving")
	arrow_animations_3.play("arrow7_moving")
	arrow_animations_4.play("arrow6_moving")
	arrow_animations_5.play("arrow4_moving")
	arrow_animations_6.play("arrow5_moving")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fridge_entered == true and Input.is_action_just_pressed("click"):
		if eating_count < 3:
			eating_audio.stream = eating_audio_activate
			eating_audio.play()
			animation_player.play("consuming_front")
			_on_character_eat()
			eating_count +=1
		else:
			animation_player.play("no_nodding_front")
	

	if bed_made == true:
		if bed_entered == true and Input.is_action_just_pressed("click"):
			if tasks.tasks_done == true:
				fading.play("day_fade_in")
				await fading.animation_finished
				_on_go_sleep()
				bed_entered = false
				get_tree().change_scene_to_file("res://GUI/background_destroyed.tscn")
				#add scene change 
			else:
				animation_player.play("no_nodding_front")
				print ("I still have tasks to do")
			
	if making_bed_area_entered == true and Input.is_action_just_pressed("click"):
		unmade_bed.visible = false
		made_bed.visible = true
		_on_make_bed()
		making_bed_area_entered = false
		bed_made = true
		
	if comp_entered == true and Input.is_action_just_pressed("click"):
		computer_2.visible = true
		if message_sound == false:
			message.play()
			message_sound = true
		if message_click.mouse_enter and Input.is_action_just_pressed("click"):
			message_screen.visible = true
			_on_use_comp()
			
				

	#investigation code
	if current_investigation_point != "" and Input.is_action_just_pressed("click"):
		investigate_point(current_investigation_point)


func investigate_point(point_id: String) ->void:
	if investigated_items.has(point_id) and not investigated_items[point_id]:
		investigated_items[point_id] = true
		investigation_found +=1
		
		match point_id:
			"torn_changer":
				arrow.visible =false
				
				dialogue_manager.show_messages([
				{"speaker": "You", "portrait": preload("res://Scared_Portrait.png"), "text": "What?"},
				{"speaker": "You", "portrait": preload("res://Scared_Portrait.png"), "text": "How did this get all torn up?"},
				{"speaker": "You", "portrait": preload("res://Scared_Portrait.png"), "text": "What could have done this?"}], dialogue_position.dialogue_position)
			"moved_chair":
				arrow_3.visible = false
				dialogue_manager.show_messages([
				{"speaker": "You", "portrait": preload("res://Normal_portrait.png"), "text": "Ugh! I should clean up more around here."},
				{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "Can't have my apartment all in a mess."}], dialogue_position.dialogue_position)
			"wilted_plants":
				arrow_7.visible = false
				dialogue_manager.show_messages([
				{"speaker": "You", "portrait": preload("res://Scared_Portrait.png"), "text": "Oh no! What happened to my plants? They're all wilted."},
				{"speaker": "You", "portrait": preload("res://Scared_Portrait.png"), "text": "I thought I was taking good care of them."},
				{"speaker": "You", "portrait": preload("res://Scared_Portrait.png"), "text": "I must have done something wrong."}], dialogue_position.dialogue_position)
			"leaking_fridge":
				arrow_4.visible = false
				dialogue_manager.show_messages([
				{"speaker": "You", "portrait": preload("res://Scared_Portrait.png"), "text": "Is this frigde leaking?"},
				{"speaker": "You", "portrait": preload("res://Scared_Portrait.png"), "text": "Something must have gone bad inside."}], dialogue_position.dialogue_position)
			"torn_bathroom_rug":
				arrow_6.visible = false
				dialogue_manager.show_messages([
				{"speaker": "You", "portrait": preload("res://Scared_Portrait.png"), "text": "Did the cat do this?"},
				{"speaker": "You", "portrait": preload("res://Scared_Portrait.png"), "text": "Maybe I should get her some more toys to play with instead of her tearing my rugs."}], dialogue_position.dialogue_position)
			"broken_desk":
				arrow_5.visible = false
				dialogue_manager.show_messages([
				{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "I knew these thrifted items would give up on me one day."},
				{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "I should probably find a way to fix this."}], dialogue_position.dialogue_position)

		if investigation_found >= investigation_total:
			_on_investigation_complete()

#marking investigation
func _on_investigation_complete()->void:
	if not investigation_completed:
		investigation_completed = true
		task_list.mark_task_complete("Investigate")
		print("Investigation Done.")

func _on_make_bed():
	task_list.mark_task_complete("Make bed")

func _on_character_eat():
	task_list.mark_task_complete("Have meal")
	#add audio thasdt shows its complete

	
func _on_go_sleep():
	task_list.mark_task_complete("Go to bed")
	
func _on_use_comp():
	task_list.mark_task_complete("Use Computer")
	
func _on_answer_phone():
	task_list.mark_task_complete("Answer Phone")
	
#BED AREA -- THIS HAS TO BE DONE LAST. CANT LET THE PLAYER GO TO SLEEP WITHOUT 
#COMPLETING OTHER TASKS 

func _on_bed_body_entered(body: Node2D) -> void:
	bed_entered = true

func _on_bed_body_exited(body: Node2D) -> void:
	bed_entered = false # Replace with function body.

#EATING AREA
func _on_fridge_food_body_entered(body: Node2D) -> void:
	fridge_entered  = true # Replace with function body.
	

func _on_fridge_food_body_exited(body: Node2D) -> void:
	fridge_entered  = false # Replace with function body.


func _on_computer_body_entered(body: Node2D) -> void:
	comp_entered = true
	pass # Replace with function body.


func _on_computer_body_exited(body: Node2D) -> void:
	comp_entered = false
	pass # Replace with function body.


#PLANTS
func _on_bed_plant_body_entered(body: Node2D) -> void:
	if body == player:
		current_investigation_point ="wilted_plants" #  # Replace with function body.

func _on_bed_plant_body_exited(body: Node2D) -> void:
	if body == player and current_investigation_point == "wilted_plants":
		current_investigation_point = "" # Replace with function body.



#making the bed
func _on_bed_making_body_entered(body: Node2D) -> void:
	making_bed_area_entered = true # Replace with function body.


func _on_bed_making_body_exited(body: Node2D) -> void:
	making_bed_area_entered = false



#LABEL

func _on_dialogue_manager_finished() -> void:
	next_label.visible = false # Replace with function body.


func _on_dialogue_manager_message_completed() -> void:
	next_label.visible = true # Replace with function body.


func _on_dialogue_manager_message_requested() -> void:
	next_label.visible = false # Replace with function body.
	
	
	

#investigation areas
func _on_changer_body_entered(body: Node2D) -> void:
	if body == player:
		current_investigation_point ="torn_changer" # Replace with function body.


func _on_changer_body_exited(body: Node2D) -> void:
	if body == player and current_investigation_point == "torn_changer":
		current_investigation_point = "" # Replace with function body.


func _on_moved_chair_body_entered(body: Node2D) -> void:
	if body == player:
		current_investigation_point ="moved_chair" # Replace with function body.


func _on_moved_chair_body_exited(body: Node2D) -> void:
	if body == player and current_investigation_point == "moved_chair":
		current_investigation_point = ""  # Replace with function body.


func _on_fridge_liquid_body_entered(body: Node2D) -> void:
	if body == player:
		current_investigation_point ="leaking_fridge" # Replace with function body.


func _on_fridge_liquid_body_exited(body: Node2D) -> void:
	if body == player and current_investigation_point == "leaking_fridge":
		current_investigation_point = ""  # Replace with function body.


func _on_broken_table_body_entered(body: Node2D) -> void:
	if body == player:
		current_investigation_point ="broken_desk" # Replace with function body.


func _on_broken_table_body_exited(body: Node2D) -> void:
	if body == player and current_investigation_point == "broken_desk":
		current_investigation_point = ""  # Replace with function body.


func _on_torn_rug_body_entered(body: Node2D) -> void:
	if body == player:
		current_investigation_point ="torn_bathroom_rug" 


func _on_torn_rug_body_exited(body: Node2D) -> void:
	if body == player and current_investigation_point == "torn_bathroom_rug":
		current_investigation_point = ""  



func _on_phone_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		if phone_answered == false:
			dialogue_manager.show_messages([
	{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "Hello?"},
	{"speaker": "Unknown", "portrait": preload("res://Horror/Free-Cursed-Land-Top-Down-Pixel-Art-Tileset/PNG/Objects_separetely/Bones_shadow1_2.png"), "text": "*Silent breathing...*"},
	{"speaker": "You", "portrait": preload("res://Scared_Portrait.png"), "text": "Who's this?"},
	{"speaker": "Unknown", "portrait": preload("res://Horror/Free-Cursed-Land-Top-Down-Pixel-Art-Tileset/PNG/Objects_separetely/Bones_shadow1_2.png"), "text": "They are watching. They beacon you..."},
	{"speaker": "Unknown", "portrait": preload("res://Horror/Free-Cursed-Land-Top-Down-Pixel-Art-Tileset/PNG/Objects_separetely/Bones_shadow1_2.png"), "text": "Soon child..."},
	{"speaker": "You", "portrait": preload("res://Scared_Portrait.png"), "text": "What?! Who is this?"},
	{"speaker": "You", "portrait": preload("res://Normal_portrait.png"), "text": "Oh, the line disconnected."}
], dialogue_position.dialogue_position)

			_on_answer_phone()
			phone_answered = true
		
		
