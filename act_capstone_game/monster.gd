class_name Monster extends Area2D
@onready var dialogue_manager: DialogueManager = $"../Main/DialogueManager"
@export var dialogue_position: DialogueMain_Day3
@onready var monster_icon: Sprite2D = $"../monster_icon"
@onready var monster_done = false
@onready var monster_entered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if monster_entered and Input.is_action_just_pressed("click"):
		monster_icon.visible = false
		dialogue_manager.show_messages([
		{"speaker": "Monster", "portrait": null, "text":"..."},
		{"speaker": "You", "portrait": preload("res://Normal_portrait.png"), "text":"Hello?"},
		{"speaker": "Monster", "portrait": null, "text":"Hi..."},
		{"speaker": "You", "portrait": preload("res://Normal_portrait.png"), "text":"Are you okay?"},
		{"speaker": "Monster", "portrait": null, "text":"Mhm..."},
		{"speaker": "Monster", "portrait": null, "text":"Goodbye now."},
				{"speaker": "You", "portrait": preload("res://Normal_portrait.png"), "text":"Oh, okay. Bye."}
		], dialogue_position.dialogue_position)
		monster_done = true 

func _on_body_entered(body: Node2D) -> void:
	monster_entered = true


func _on_body_exited(body: Node2D) -> void:
	monster_entered = false
	dialogue_manager._hide()
	 # Replace with function body.
