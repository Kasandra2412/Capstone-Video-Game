class_name Trapped extends Area2D
@onready var dialogue_manager: DialogueManager = $"../Main/DialogueManager"
@export var dialogue_position: DialogueMain_Day3
@onready var trapped_icon: Sprite2D = $"../trapped_icon"
@onready var trapped_done = false
@onready var trapped_entered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if trapped_entered and Input.is_action_just_pressed("click"):
		trapped_icon.visible = false
		dialogue_manager.show_messages([
		{"speaker": "Trapped", "portrait": null, "text":"H..."},
		{"speaker": "Trapped", "portrait": null, "text":"E..."},
		{"speaker": "Trapped", "portrait": null, "text":"L..."},
		{"speaker": "Trapped", "portrait": null, "text":"P..."},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text":"You need help?"},
		{"speaker": "Trapped", "portrait": null, "text":"Trapped..."},
		{"speaker": "You", "portrait": preload("res://Scared_portrait.png"), "text":"What happened to you?"},
		{"speaker": "Trapped", "portrait": null, "text":"Can't leave."},
		{"speaker": "Trapped", "portrait": null, "text":"Alone"}
		], dialogue_position.dialogue_position)
		trapped_done = true  


func _on_body_entered(body: Node2D) -> void:
	trapped_entered = true


func _on_body_exited(body: Node2D) -> void:
	trapped_entered = false
	dialogue_manager._hide()
	
