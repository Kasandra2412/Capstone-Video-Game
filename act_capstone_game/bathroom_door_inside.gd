extends Area2D
@onready var player: Player = $"../Player"
var entered = false
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
var pressed = false
@onready var split_container: VBoxContainer = $"../Leave_Bathroom"


@onready var audio: AudioStreamPlayer2D = $"../Door_opening"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if entered == true:
		split_container.visible = true
		if pressed == true:
			split_container.visible = false
			audio.play()
			animation_player.play("fade_in")
			if audio.finished:
				await animation_player.animation_finished
				player.position = Vector2(541, 201)
				animation_player.play("fade_out")
			entered = false
			pressed = false
	else:
		split_container.visible = false
	
func _on_body_entered(body: Node2D) -> void:
	entered = true


func _on_body_exited(body: Node2D) -> void:
	entered = false # Replace with function body.


func _on_button_pressed() -> void:
	pressed = true # Replace with function body.
