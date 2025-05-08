extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var dialogue_position: TrustMain
@onready var dialogue_manager: DialogueManager = $Main/DialogueManager
@onready var background: AudioStreamPlayer2D = $background

var dialogue_done = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("fade_in") # Replace with function body.
	await animation_player.animation_finished
	background.play()
	
	if dialogue_done == false:
		dialogue_manager.show_messages([
	{"speaker": "Unknown", "portrait": null, "text": "You chose Trust."},
	{"speaker": "Unknown", "portrait": null, "text": "You are not in pain anymore."},
	{"speaker": "Unknown", "portrait": null, "text": "Here there's nothing."},
	{"speaker": "Unknown", "portrait": null, "text": "But you will feel peace."},
	{"speaker": "Unknown", "portrait": null, "text": "Now rest..."}], dialogue_position.dialogue_position)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_dialogue_manager_finished() -> void:
	animation_player.play("fade_out") 
	await animation_player.animation_finished
	get_tree().quit()
