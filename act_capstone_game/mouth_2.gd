class_name Mouth_2 extends Area2D

@onready var dialogue_manager: DialogueManager = $"../Main/DialogueManager"
@export var dialogue_position: DialogueMain_Day3
var mouth2_done = false
var mouth2_entered = false
var dialogue_done = false


@export var eye: Eye
@export var monster: Monster
@export var trapped: Trapped
@onready var mouth_2: AnimationPlayer = $"../Mouth2"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouth2_entered:
		if eye.eye_done == true and monster.monster_done == true and trapped.trapped_done == true:
			dialogue_manager.show_messages([
		{"speaker": "Mouth 2", "portrait": null, "text":"Ah! I heard you came."},
		{"speaker": "Mouth 2", "portrait": null, "text":"Strange... I thought you would look worse."},
		{"speaker": "Mouth 2", "portrait": null, "text":"Well, I assume my brother spoke to you when you came in."},
		{"speaker": "Mouth 2", "portrait": null, "text":"Now this book up there speaks of a greater story than yourself."},
		{"speaker": "Mouth 2", "portrait": null, "text":"Go on- open it. Let it enlighten you."},
		{"speaker": "Mouth 2", "portrait": null, "text":"Don't... linger too long. Knowledge here, it tends to warp your mind."},
		{"speaker": "Mouth 2", "portrait": null, "text":"When you're done, take a right and you will find what you're looking for."}
		], dialogue_position.dialogue_position)
			mouth2_done = true 
			mouth2_entered = false
		else:
			if dialogue_done == false:
				dialogue_manager.show_messages([
		{"speaker": "Mouth 2", "portrait": null, "text":"Speak to the creatures first."}], dialogue_position.dialogue_position)
				dialogue_done = true

func _on_mouth_2_body_entered(body: Node2D) -> void:
	mouth2_entered = true
	mouth_2.play("mouth2_moving")

func _on_mouth_2_body_exited(body: Node2D) -> void:
	mouth_2.play("mouth2_closing")
	dialogue_manager._hide() 
	
