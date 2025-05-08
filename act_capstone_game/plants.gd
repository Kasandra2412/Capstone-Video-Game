extends Node2D
@onready var animation_player: AnimationPlayer = $Player/AnimationPlayer

var is_watered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func water():
	if not is_watered:
		is_watered = true
		animation_player.play("yes_nodding_front")
		print ("flower has been watered!")
