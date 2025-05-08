class_name Monster_Area extends Area2D
@onready var dialogue_manager: DialogueManager = $"../Main/DialogueManager"
@export var dialogue_position: DialogueMain_Day3

@onready var monster_open: TileMapLayer = $"../Monster_Open"
var dialogue_finished = false
@onready var trust: Button = $"../Trust"
@onready var button: Button = $"../Button"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monster_open.visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dialogue_finished == true:
		trust.visible = true
		button.visible = true


func _on_body_entered(body: Node2D) -> void:
	monster_open.visible = true # Replace with function body.
	dialogue_manager.show_messages([
	{"speaker": "All-knowing", "portrait": preload("res://Monster_portrait.png"), "text": "You made it."},
	{"speaker": "All-knowing", "portrait": preload("res://Monster_portrait.png"), "text": "I have been waiting for you. I knew you would come."},
	{"speaker": "You", "portrait": preload("res://Normal_Portrait.png"), "text": "Who are you? What is this place?"},
	{"speaker": "All-knowing", "portrait": preload("res://Monster_portrait.png"), "text": "You came here to find answers. Answers you shall find."},
	{"speaker": "All-knowing", "portrait": preload("res://Monster_portrait.png"), "text": "It all depends on you. You can trust me or not."},
	{"speaker": "All-knowing", "portrait": preload("res://Monster_portrait.png"), "text": "Either way, it's your decision."}
], dialogue_position.dialogue_position)


func _on_dialogue_manager_finished() -> void:
	dialogue_finished = true # Replace with function body.
