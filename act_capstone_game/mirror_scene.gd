class_name Mirror extends Node2D
@export var dialogue_position: DialogueMirror
@onready var dialogue_manager: DialogueManager = $Main/DialogueManager
@onready var flicker_timer: Timer = $Flicker_Timmer
var flickering = false
var has_triggered = false
@onready var horror_timer: Timer = $Horror_Timer
@export var dialogue_done: DialogueManager
@export var sec_dialogue_done: DialogueManager
@onready var mirror_scene: Mirror = $"."



@onready var normal_reflection: Sprite2D = $Normal_reflection
@onready var horror_reflection: Sprite2D = $Horror_reflection
@onready var scared_reflection: Sprite2D = $Scared_reflection


var shown_dialogue = false
var last_dialogue = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mirror_scene.visible = false
	normal_reflection.visible = true
	horror_reflection.visible = false
	scared_reflection.visible = false 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mirror_scene.visible == true:
		if shown_dialogue == false:
			dialogue_manager.show_messages([
			{"speaker": "You", "portrait": preload("res://Normal_portrait.png"), "text": "Huh? *chuckles*"},
			{"speaker": "You", "portrait": preload("res://Normal_portrait.png"), "text": "Well, I look normal."},
			{"speaker": "You", "portrait": preload("res://Normal_portrait.png"), "text": "I guess I am not drea--"}
			], dialogue_position.dialogue_position)
			shown_dialogue = true
			
		if dialogue_done.message_done == true:
			if has_triggered == false:
				start_flicker_and_stop()
				has_triggered = true


func _on_flicker_timmer_timeout() -> void:
	if flickering:
		var currently_showing_normal = normal_reflection.visible
		normal_reflection.visible = !currently_showing_normal
		horror_reflection.visible = currently_showing_normal

func start_flicker():
	flickering = true
	flicker_timer.start()
	
func stop_flicker():
	flickering = false
	flicker_timer.stop()
	scared_reflection.visible = true
	horror_reflection.visible = false
	normal_reflection.visible = false
	
	if last_dialogue == false:
		dialogue_manager.show_messages([
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "What was that?!"},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "Am I really dreaming?"},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text": "Ugh. My brain must be playing tricks on me."}
		], dialogue_position.dialogue_position)
		last_dialogue = true


func start_flicker_and_stop():
	start_flicker()
	horror_timer.start(3.5)

func _on_horror_timer_timeout() -> void:
	stop_flicker() # Replace with function body.
	flickering = false


func _on_button_pressed() -> void:
	dialogue_manager._hide()
	mirror_scene.visible = false # Replace with function body.
