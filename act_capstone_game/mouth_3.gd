class_name Mouth3 extends Area2D

@onready var dialogue_manager: DialogueManager = $"../Main/DialogueManager"
@export var dialogue_position: DialogueMain_Day3
@export var book: HiddenRoom
var dialogue_done = false
@onready var mouth_3: AnimationPlayer = $"../Mouth3"


var mouth3_done = false
var mouth3_entered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if book.read_book:
		if mouth3_entered:
			dialogue_manager.show_messages([
		{"speaker": "Mouth 3", "portrait": null, "text":"...You made it..."},
		{"speaker": "Mouth 3", "portrait": null, "text":"*silence*"},
		{"speaker": "Mouth 3", "portrait": null, "text":"Everything is now on your hands."},
		{"speaker": "Mouth 3", "portrait": null, "text":"You decide your fate."},
		{"speaker": "Mouth 3", "portrait": null, "text":"But, rememeber that your choice will have consequences."}
		], dialogue_position.dialogue_position)
			mouth3_done = true
			mouth3_entered = false
	else:
		if mouth3_entered and dialogue_done == false:
			dialogue_manager.show_messages([
		{"speaker": "Mouth 3", "portrait": null, "text":" You must speak with my brother first."}], dialogue_position.dialogue_position)
			dialogue_done = true
func _on_mouth_3_body_entered(body: Node2D) -> void:
	mouth3_entered = true
	mouth_3.play("mouth3_opened")


func _on_mouth_3_body_exited(body: Node2D) -> void:
	dialogue_manager._hide()
	mouth3_done = false
	mouth_3.play("mouth3_closed")
