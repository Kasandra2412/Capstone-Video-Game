class_name TvScreen extends Node2D

@onready var dialogue_manager: DialogueManager = $"../Main/DialogueManager"
@export var dialogue_position: DialogueMainDay3
var dialogue_end= false
@onready var tv: TvScreen = $"."
@onready var tv_static: AudioStreamPlayer2D = $TvStatic


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tv.visible = false# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dialogue_end == false and tv.visible:
		tv_static.play()
		if dialogue_end == false and tv.visible:
			tv_static.play()
			dialogue_manager.show_messages([
		{"speaker": "News Reporter", "portrait": null, "text": "In local news, authorities continue to investigate a recent missing persons case."},
		{"speaker": "News Reporter", "portrait": null, "text": "The individual, a young woman, was last seen several weeks ago in her apartment complex."},
		{"speaker": "News Reporter", "portrait": null, "text": "Despite ongoing efforts, police report no significant leads at this time."},
		{"speaker": "News Reporter", "portrait": null, "text": "Anyone with information is urged to contact local law enforcement. Your assistance could be critical."}
	], dialogue_position.dialogue_position)
		dialogue_end = true



func _on_button_pressed() -> void:
	tv_static.stop()
	dialogue_manager._hide()
	tv.visible = false # Replace with function body.
