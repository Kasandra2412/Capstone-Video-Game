class_name HiddenRoom2 extends Node2D
@onready var dialogue_manager: DialogueManager = $Main/DialogueManager
@export var dialogue_position: DialogueMain_Day3
@onready var fading: AnimationPlayer = $AnimationPlayer
@onready var background: AudioStreamPlayer2D = $Background


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.play()
	fading.play("day_fade_out")
	await fading.animation_finished
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#trust button
func _on_trust_pressed() -> void:
	fading.play("day_fade_in")
	await fading.animation_finished
	get_tree().change_scene_to_file("res://trust_choice.tscn") # Replace with function body.


#not trust button
func _on_button_pressed() -> void:
	fading.play("day_fade_in")
	await fading.animation_finished
	get_tree().change_scene_to_file("res://nontrust_choice.tscn") # Replace with function body.
 # Replace with function body.
