class_name ToDoListDay2 extends Control
@onready var tasks_done = false
@onready var phone_2: Sprite2D = $"../Phone2"
var phone_rang = false
@onready var phone_sound: AudioStreamPlayer2D = $"../Phone_Sound"
@export var comp_closed: ComputerDay2


var tasks = {
	"Make bed": false,
	"Investigate": false,
	"Use Computer": false,
	"Answer Phone": false,
	"Have meal": false,
	"Go to bed": false
}
@onready var task_container: VBoxContainer = $CanvasLayer/VBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_task_list() # Replace with function body.

func _process(delta: float) -> void:
	if all_tasks_complete():
		tasks_done = true
		print("All tasks are complete!")
		
	if comp_closed.button_pressed == true and phone_rang == false:
			phone_sound.play()
			phone_rang = true
			
	if tasks["Answer Phone"]:
		phone_sound.stop()
		phone_2.visible = false
		

func mark_task_complete(task_name):
	if task_name in tasks:
		tasks[task_name] = true
		update_task_list()
		
func update_task_list():
	
	for child in task_container.get_children():
		task_container.remove_child(child)
		child.queue_free()
	
	for task in tasks:
		if task == "Answer Phone" and not tasks["Use Computer"]:
			continue
		var label = Label.new()
		var fv = FontVariation.new()
		fv.base_font = load("res://GUI/Role_Playing_Fonts_4_Mini/MiniCard.ttf")
		label.add_theme_font_override("font", fv)
		label.add_theme_font_size_override("font_size", 16)
		if tasks[task]:
			label.text = "✔ " + task
			label.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5))
			
		else:
			label.text ="☐ " + task
			
		task_container.add_child(label)
	
	if tasks.has("Answer Phone") and tasks["Use Computer"]:
		phone_2.visible = true
	else:
		phone_2.visible = false
	
func all_tasks_complete() -> bool:
	for task in tasks:
		if task == "Go to bed":
			continue
		if not tasks[task]:
			return false
	return true
