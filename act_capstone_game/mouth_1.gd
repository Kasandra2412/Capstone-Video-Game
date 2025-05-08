class_name Mouth1 extends Area2D

@onready var dialogue_manager: DialogueManager = $"../Main/DialogueManager"
@export var dialogue_position: DialogueMain_Day3
var mouth1_done = false
@onready var mouth_1: AnimationPlayer = $"../Mouth1"




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouth_1_body_entered(body: Node2D) -> void:
	mouth_1.play("mouth1_opening")
	dialogue_manager.show_messages([
		{"speaker": "Mouth 1", "portrait": null, "text":"Hello there, little lady."},
		{"speaker": "Mouth 1", "portrait": null, "text":"I see you found us."},
		{"speaker": "Mouth 1", "portrait": null, "text":"Finally."},
		{"speaker": "Mouth 1", "portrait": null, "text":"I almost thought you'd rot in that little apartment of yours."},
		{"speaker": "Mouth 1", "portrait": null, "text":"But here you are... breathing and somewhat sane."},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text":"What is this place?"},
		{"speaker": "Mouth 1", "portrait": null, "text":"Curious, aren't you? Of where you've wandered?"},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text":"I had no idea this place existed."},
		{"speaker": "Mouth 1", "portrait": null, "text":"How about you speak to some of the creatures here."},
		{"speaker": "Mouth 1", "portrait": null, "text":"Then swing by my brother on the left. He will help with what you need to know."}
		], dialogue_position.dialogue_position)


func _on_mouth_1_body_exited(body: Node2D) -> void:
	mouth_1.play("mouth1_closing")
	dialogue_manager._hide() # Replace with function body.


func _on_dialogue_manager_finished() -> void:
	mouth1_done = true # Replace with function body.
