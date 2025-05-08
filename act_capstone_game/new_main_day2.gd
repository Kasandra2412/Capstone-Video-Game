class_name DialogueMain extends Control
@onready var dialogue_manager: DialogueManager = $DialogueManager
@onready var next_label: Label = $NextLabel
@onready var dialogue_position := get_node("DialoguePosition").position as Vector2

@export var tasks: Room_Day2
@export var eating: Room_Day2
@export var all_tasks: ToDoListDay2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_label.visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bed_body_entered(body: Node2D) -> void:
	if tasks.bed_made == true:
		if all_tasks.tasks_done == false:
			dialogue_manager.show_messages([
			{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "I should finish all my tasks first..."}], dialogue_position)
		else:
			dialogue_manager.show_messages([
			{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "Things  were weird today. Maybe I just need some sleep..."},
			{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "Goodnight."}], dialogue_position)

func _on_bed_body_exited(body: Node2D) -> void:
	dialogue_manager._hide() # Replace with function body.

#LABEL

func _on_dialogue_manager_finished() -> void:
	next_label.visible = false # Replace with function body.


func _on_dialogue_manager_message_completed() -> void:
	next_label.visible = true # Replace with function body.


func _on_dialogue_manager_message_requested() -> void:
	next_label.visible = false # Replace with function body.
