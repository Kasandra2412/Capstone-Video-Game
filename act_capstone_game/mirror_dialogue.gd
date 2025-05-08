class_name DialogueMirror extends Control
@onready var dialogue_manager: DialogueManager = $DialogueManager
@onready var next_label: Label = $NextLabel
@onready var dialogue_position := get_node("DialoguePosition").position as Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_label.visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



#LABEL

func _on_dialogue_manager_finished() -> void:
	next_label.visible = false # Replace with function body.


func _on_dialogue_manager_message_completed() -> void:
	next_label.visible = true # Replace with function body.


func _on_dialogue_manager_message_requested() -> void:
	next_label.visible = false # Replace with function body.
