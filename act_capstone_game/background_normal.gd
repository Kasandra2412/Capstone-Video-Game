class_name Main extends Node2D
@onready var player: Player = $Player
@onready var animation_player: AnimationPlayer = $Player/AnimationPlayer
@onready var fading: AnimationPlayer = $AnimationPlayer
@onready var eating_count: int = 0
@onready var plant_count = 0
@export var tasks : ToDoList
@onready var plants: Node2D = $Plants
@onready var task_list: Control = $ToDoList
@onready var dialogue_manager: DialogueManager = $Main/DialogueManager
@onready var computer_2: Computer = $Computer2
@onready var mirror_scene: Mirror = $Mirror_Scene
@export var mirror_done: Mirror
var watered_plants = false
@export var message_enter: Message
var comp_used = false

@onready var computer_collision: CollisionShape2D = $Computer/CollisionShape2D

@export var button_pressed: Computer
@onready var message_screen: Sprite2D = $Computer2/MessageScreen




#QUESTION MARKS
@onready var fridge: Sprite2D = $QuestionMarks/Fridge
@onready var bed_plant: Sprite2D = $QuestionMarks/BedPlant
@onready var living_plant: Sprite2D = $QuestionMarks/LivingPlant
@onready var comp: Sprite2D = $QuestionMarks/Comp
@onready var bath_plant: Sprite2D = $QuestionMarks/BathPlant
@onready var mirror: Sprite2D = $QuestionMarks/Mirror
var message_played = false


#AUDIOS 
@onready var eating_audio: AudioStreamPlayer2D =$Eating
@onready var eating_audio_activate : AudioStream = preload("res://audios/eating-sound-effect-36186.mp3")
@onready var watering: AudioStreamPlayer2D = $Watering
@onready var background: AudioStreamPlayer2D = $Background
@onready var message: AudioStreamPlayer2D = $Computer2/Message




var bed_entered = false
var fridge_entered = false
var plant_entered = false
var live_plant = false
var bathr_plant = false
var comp_entered = false
var mirror_entered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.play()
	fading.play("day_fade_out")
	await fading.animation_finished
	mirror_scene.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fridge_entered == true and Input.is_action_just_pressed("click"):
		fridge.visible = false
		if eating_count < 3:
			eating_audio.stream = eating_audio_activate
			eating_audio.play()
			animation_player.play("consuming_front")
			_on_character_eat()
			eating_count +=1
		else:
			animation_player.play("no_nodding_front")


	if plant_entered == true and Input.is_action_just_pressed("click"):
		watering.play()
		bed_plant.visible = false
		plant_count +=1
		print(plant_count)
		animation_player.play("yes_nodding_front")
		plant_entered = false
	if bathr_plant == true and Input.is_action_just_pressed("click"):
		watering.play()
		bath_plant.visible=false
		plant_count +=1
		print(plant_count)
		animation_player.play("yes_nodding_front")
		bathr_plant = false
	if live_plant == true and Input.is_action_just_pressed("click"):
		watering.play()
		living_plant.visible = false
		plant_count +=1
		print(plant_count)
		animation_player.play("yes_nodding_front")
		live_plant = false
	
	if plant_count == 3 and not watered_plants:
		_on_water_plants()
		watered_plants = true


	if bed_entered == true and Input.is_action_just_pressed("click"):
		if tasks.tasks_done == true:
			_on_go_sleep()
			fading.play("day_fade_in")
			await fading.animation_finished
			get_tree().change_scene_to_file("res://background_day2.tscn")
			bed_entered = false
			#add scene change 
		else:
			animation_player.play("no_nodding_front")
			print ("I still have tasks to do")
			
	if comp_entered == true and Input.is_action_just_pressed("click"):
		comp.visible = false
		computer_2.visible = true
		if message_played == false:
			message.play()
			message_played = true
		if message_enter.mouse_enter and Input.is_action_just_pressed("click"):
			message_screen.visible = true
			_on_use_comp()
			comp_used = true

	if comp_used == true:
		if mirror_entered == true and Input.is_action_just_pressed("click"):
			mirror.visible = false
			mirror_scene.visible = true
			if mirror_done.last_dialogue == true:
				mirror_scene.visible = false
			_on_mirror_used()
# Replace with function body.


func _on_mirror_used():
	task_list.mark_task_complete("Check mirror")

func _on_character_eat():
	task_list.mark_task_complete("Have meal")

func _on_water_plants():
	task_list.mark_task_complete("Water plants(3)")

func _on_go_sleep():
	task_list.mark_task_complete("Go to bed")

func _on_use_comp():
	task_list.mark_task_complete("Use Computer")

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

func _on_mirror_body_entered(body: Node2D) -> void:
	mirror_entered = true
	
func _on_mirror_body_exited(body: Node2D) -> void:
	mirror_entered = false



#PLANTS
func _on_bed_plant_body_entered(body: Node2D) -> void:
	plant_entered = true # Replace with function body.


func _on_bath_plant_body_entered(body: Node2D) -> void:
	bathr_plant = true # Replace with function body.


func _on_living_plant_body_entered(body: Node2D) -> void:
	live_plant = true
	
func _on_bed_plant_body_exited(body: Node2D) -> void:
	plant_entered = false # Replace with function body.


func _on_bath_plant_body_exited(body: Node2D) -> void:
	bathr_plant = false
	
func _on_living_plant_body_exited(body: Node2D) -> void:
	live_plant = false # Replace with function body.
