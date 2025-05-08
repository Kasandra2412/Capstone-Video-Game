class_name Computer extends Node2D
@onready var message_screen: Sprite2D = $MessageScreen
@onready var node_2d: Computer = $"."
@onready var button_pressed = false




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	message_screen.visible = false # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	node_2d.visible = false
	button_pressed = true
	
