extends Control
@onready var dialogue_manager: DialogueManager = $DialogueManager
@onready var next_label: Label = $NextLabel
@onready var dialogue_position := get_node("DialoguePosition").position as Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_label.visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_dialogue_manager_finished() -> void:
	next_label.visible = false # Replace with function body.


func _on_dialogue_manager_message_completed() -> void:
	next_label.visible = true # Replace with function body.


func _on_dialogue_manager_message_requested() -> void:
	next_label.visible = false # Replace with function body.


func _on_bed_plant_body_entered(body: Node2D) -> void:
	randomize()  # Good practice to call once before using randi()
	
	var dialogue_options = [
		["These plants are growing nicely!"],
		["So green and lively!"],
		["Looks like the watering paid off."],
		["Maybe I should plant more someday."]
	]
	
	var random_index = randi() % dialogue_options.size()
	var selected_dialogue = dialogue_options[random_index]
	
	dialogue_manager.show_messages(selected_dialogue, dialogue_position)


func _on_bed_plant_body_exited(body: Node2D) -> void:
	dialogue_manager._hide() # Replace with function body.
