class_name Dialogue extends Control

@onready var content: RichTextLabel = $Content
@onready var type_timer: Timer = $TypeTimer
@onready var portrait: TextureRect = $Portrait
@onready var speaker_name: Label = $SpeakerName

signal message_completed()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func update_message(message: Dictionary)->void:
	content.bbcode_text=message.get("text", "")
	content.visible_characters =0
	speaker_name.text = message.get("speaker","")
	var portrait_texture: Texture2D = message.get("portrait", null)
	portrait.texture = portrait_texture
	type_timer.start()
	

# Returns true if there are no pending characters to show
func message_is_fully_visible() -> bool:
	return content.visible_characters >= content.text.length() - 1
	
func _on_type_timer_timeout() -> void:
	if content.visible_characters<content.text.length():
		content.visible_characters +=1
	else:
		type_timer.stop()
		emit_signal("message_completed")
