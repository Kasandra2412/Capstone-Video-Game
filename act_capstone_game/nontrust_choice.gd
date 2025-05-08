extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var dialogue_position: NonTrustMain
@onready var dialogue_manager: DialogueManager = $Main/DialogueManager
@onready var whispers: AudioStreamPlayer2D = $Whispers


var dialogue_done = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("fade_in") # Replace with function body.
	await animation_player.animation_finished
	whispers.play()
	if dialogue_done == false:
		dialogue_manager.show_messages([
	{"speaker": "Unknown", "portrait": null, "text": "You chose Not Trust."},
	{"speaker": "Unknown", "portrait": null, "text": "You went back to your normal life."},
	{"speaker": "Unknown", "portrait": null, "text": "Things got worse."},
	{"speaker": "Unknown", "portrait": null, "text": "No matter what you did the voices wouldn't stop."},
	{"speaker": "Unknown", "portrait": null, "text": "You have reached your end. They will always be watching you."}], dialogue_position.dialogue_position)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_dialogue_manager_finished() -> void:
	animation_player.play("fade_out") 
	await animation_player.animation_finished
	get_tree().quit()
