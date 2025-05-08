class_name DialogueManager extends Node

const DIALOGUE_SCENE := preload("res://dialogue.tscn")


#@onready var opacity_tween :=get_node("OpacityTween") as Tween

signal message_requested()
signal message_completed()
signal finished()

var _messages:=[]
var _active_dialogue_offset :=0
var _is_active := false
@onready var message_done = false


var cur_dialogue_instance: Dialogue

func _input(event: InputEvent) -> void:
	if (
		event.is_pressed() and !event.is_echo() and
		event is InputEventKey and 
		(event as InputEventKey).keycode == KEY_SPACE and _is_active and 
		cur_dialogue_instance.message_is_fully_visible()
	):
		if _active_dialogue_offset < _messages.size() -1:
			_active_dialogue_offset +=1
			_show_current()
		else:
			_hide()
			

#used to build conversations with multiple strings
#and position to where the dialogue will spawn on the tree
func show_messages(message_list: Array, position: Vector2) -> void:
	if _is_active:
		return 
	_is_active = true
	
	_messages = message_list
	_active_dialogue_offset = 0
	
	
	var _dialogue = DIALOGUE_SCENE.instantiate()
	get_tree().get_root().add_child(_dialogue)
	
	_dialogue.modulate.a = 0
	_dialogue.position = position
	_dialogue.connect("message_completed", Callable(self, "_on_message_completed"))
	
	cur_dialogue_instance = _dialogue
	_dialogue.modulate.a = 1 
	
	_show_current()
	
func _show_current()-> void:
	emit_signal("message_requested")
	var _msg:Dictionary =_messages[_active_dialogue_offset]
	cur_dialogue_instance.update_message(_msg)


func _hide()->void:
	_is_active = false
	if cur_dialogue_instance == null:
		message_done = true
		emit_signal("finished")
		return

	# Ensure it's not disconnected or freed mid-tween
	if not is_instance_valid(cur_dialogue_instance):
		message_done = true
		emit_signal("finished")
		return
		
	cur_dialogue_instance.disconnect("message_completed", Callable(self, "_on_message_completed"))
	cur_dialogue_instance.disconnect("choice_selected", Callable(self, "_on_choice_selected"))

	var tween = create_tween()
	tween.tween_property(cur_dialogue_instance, "modulate:a", 0.0, 0.2)\
			.set_trans(Tween.TRANS_SINE)\
			.set_ease(Tween.EASE_IN_OUT)

	await tween.finished
	cur_dialogue_instance.queue_free()
	cur_dialogue_instance = null
	message_done = true

	emit_signal("finished")
	
func _on_message_completed()-> void:
	emit_signal("message_completed")
	
