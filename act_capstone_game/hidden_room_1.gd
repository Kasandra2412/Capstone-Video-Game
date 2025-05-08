class_name HiddenRoom extends Node2D
@onready var dialogue_manager: DialogueManager = $Main/DialogueManager
@export var dialogue_position: DialogueMain_Day3
@onready var fading: AnimationPlayer = $AnimationPlayer
@onready var read_book = false
@export var mouth2: Mouth_2
@onready var leaving_area = false

@onready var book_entered = false
@export var mouth3: Mouth3
@onready var background: AudioStreamPlayer2D = $background

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.play()
	fading.play("day_fade_out")
	await fading.animation_finished
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouth2.mouth2_done == true:
		if book_entered == true and Input.is_action_just_pressed("click"):
			dialogue_manager.show_messages([
		{"speaker": "The Book", "portrait": null, "text":"There's a being beyond comprehension."},
		{"speaker": "The Book", "portrait": null, "text":"One that sees everything. Knows everything."},
		{"speaker": "The Book", "portrait": null, "text":"It dwells where the world thins."},
		{"speaker": "The Book", "portrait": null, "text":"It can offer what you need, only if you truly know what you want."},
		{"speaker": "The Book", "portrait": null, "text":"All depends upon the seeker."},
		{"speaker": "The Book", "portrait": null, "text":"What do you want?"},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text":"This is insane."},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text":"But I suppose I am already this far."}
		], dialogue_position.dialogue_position)
		
	if mouth3.mouth3_done == true:
		if leaving_area == true and Input.is_action_pressed("up"):
			get_tree().change_scene_to_file("res://HiddenRoom2.tscn")
			fading.play("day_fade_in")
			await fading.animation_finished

func _on_book_area_body_entered(body: Node2D) -> void:
	book_entered = true 


func _on_book_area_body_exited(body: Node2D) -> void:
	book_entered = false  
	read_book = true


func _on_leaving_area_body_entered(body: Node2D) -> void:
	leaving_area = true # Replace with function body.


func _on_leaving_area_body_exited(body: Node2D) -> void:
	leaving_area = false # Replace with function body.
