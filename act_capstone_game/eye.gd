class_name Eye extends Area2D
@onready var dialogue_manager: DialogueManager = $"../Main/DialogueManager"
@export var dialogue_position: DialogueMain_Day3
@onready var eye_icon: Sprite2D = $"../eye_icon"
@onready var eye_done = false
@onready var eye_entered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if eye_entered and Input.is_action_just_pressed("click"):
		eye_icon.visible = false
		dialogue_manager.show_messages([
		{"speaker": "Eye", "portrait": null, "text":"A new friend!"},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text":"You can speak?"},
		{"speaker": "Eye", "portrait": null, "text":"Of course I can speak. You can do anything here. Be anything you want."},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text":"What if I don't know what I want?"},
		{"speaker": "Eye", "portrait": null, "text":"Well *He* will you lead you. As he lead me."},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text":"So you're happy here?"},
		{"speaker": "Eye", "portrait": null, "text":"The happiest I've been. I was lost just like you. Not anymore."}
		], dialogue_position.dialogue_position)
		eye_done = true


func _on_body_entered(body: Node2D) -> void:
	eye_entered = true


func _on_body_exited(body: Node2D) -> void:
	eye_entered = false
	dialogue_manager._hide() # Replace with function body.
	print("eye dialogue done")
	
