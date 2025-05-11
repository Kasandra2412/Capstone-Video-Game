extends Control
@onready var dialogue_manager: DialogueManager = $DialogueManager
@onready var next_label: Label = $NextLabel
@onready var dialogue_position := get_node("DialoguePosition").position as Vector2

@export var tasks: Main
@export var all_tasks: ToDoList



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_label.visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_bath_plant_body_entered(body: Node2D) -> void:
	randomize() 
	var dialogue_options = [
	{
		"speaker": "You",
		"portrait": preload("res://Normal_portrait.png"),
		"text": "These plants are growing nicely!"
	},
	{
		"speaker": "You",
		"portrait": preload("res://Normal_portrait.png"),
		"text": "So green and lively!"
	},
	{
		"speaker": "You",
		"portrait": preload("res://Normal_portrait.png"),
		"text": "Looks like the watering paid off."
	},
	{
		"speaker": "You",
		"portrait": preload("res://Normal_portrait.png"),
		"text": "Maybe I should plant more someday."
	}
]

	var random_index = randi() % dialogue_options.size()
	var selected_dialogue = dialogue_options[random_index]

	dialogue_manager.show_messages([selected_dialogue], dialogue_position)



func _on_bath_plant_body_exited(body: Node2D) -> void:
	dialogue_manager._hide() # Replace with function body.
	
func _on_living_plant_body_entered(body: Node2D) -> void:
	randomize() 
	var dialogue_options = [
	{
		"speaker": "You",
		"portrait": preload("res://Normal_portrait.png"),
		"text": "These plants are growing nicely!"
	},
	{
		"speaker": "You",
		"portrait": preload("res://Normal_portrait.png"),
		"text": "So green and lively!"
	},
	{
		"speaker": "You",
		"portrait": preload("res://Normal_portrait.png"),
		"text": "Looks like the watering paid off."
	},
	{
		"speaker": "You",
		"portrait": preload("res://Normal_portrait.png"),
		"text": "Maybe I should plant more someday."
	}
]

	var random_index = randi() % dialogue_options.size()
	var selected_dialogue = dialogue_options[random_index]

	dialogue_manager.show_messages([selected_dialogue], dialogue_position)


func _on_living_plant_body_exited(body: Node2D) -> void:
	dialogue_manager._hide() # Replace with function body.

func _on_bed_plant_body_entered(body: Node2D) -> void:
	randomize() 
	var dialogue_options = [
	{
		"speaker": "You",
		"portrait": preload("res://Normal_portrait.png"),
		"text": "These plants are growing nicely!"
	},
	{
		"speaker": "You",
		"portrait": preload("res://Normal_portrait.png"),
		"text": "So green and lively!"
	},
	{
		"speaker": "You",
		"portrait": preload("res://Normal_portrait.png"),
		"text": "Looks like the watering paid off."
	},
	{
		"speaker": "You",
		"portrait": preload("res://Normal_portrait.png"),
		"text": "Maybe I should plant more someday."
	}
]

	var random_index = randi() % dialogue_options.size()
	var selected_dialogue = dialogue_options[random_index]

	dialogue_manager.show_messages([selected_dialogue], dialogue_position)


func _on_bed_plant_body_exited(body: Node2D) -> void:
	dialogue_manager._hide() # Replace with function body.



func _on_bed_body_entered(body: Node2D) -> void:
	if all_tasks.tasks_done == false:
		dialogue_manager.show_messages([
		{"speaker": "You", "portrait": preload("res://Normal_portrait.png"), "text": "I should finish all my tasks first..."}
		], dialogue_position)


func _on_bed_body_exited(body: Node2D) -> void:
	dialogue_manager._hide() # Replace with function body.


func _on_fridge_food_body_entered(body: Node2D) -> void:
	if tasks.eating_count < 3:
		dialogue_manager.show_messages([
		{"speaker": "You", "portrait": preload("res://Normal_portrait.png"), "text":"Just got groceries. These should last me a few meals."}
		], dialogue_position)
	else:
		dialogue_manager.show_messages([
		{"speaker": "You", "portrait": preload("res://Normal_portrait.png"), "text":"Can't eat anymore."}
		], dialogue_position)

func _on_fridge_food_body_exited(body: Node2D) -> void:
	dialogue_manager._hide() 

#LABEL

func _on_dialogue_manager_finished() -> void:
	next_label.visible = false # Replace with function body.


func _on_dialogue_manager_message_completed() -> void:
	next_label.visible = true # Replace with function body.


func _on_dialogue_manager_message_requested() -> void:
	next_label.visible = false # Replace with function bod
