class_name Message extends Area2D

@onready var message_screen: Sprite2D = $"../MessageScreen"
@onready var mouse_enter = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	message_screen.visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

'''
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		print("Icon clicked!")
		message_screen.visible = true
		
'''

func _on_mouse_entered() -> void:
	mouse_enter = true 
