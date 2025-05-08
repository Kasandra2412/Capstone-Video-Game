class_name ToDoListDay3 extends Control
@onready var tasks_done = false
@onready var escape: Sprite2D = $"../Escape"


var tasks = {
	"Investigate": false,
	"Watch TV": false,
	"Try the 
	front door": false,
	"Follow the
	whispers": false,
}

@onready var task_container: VBoxContainer = $CanvasLayer/VBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_task_list() # Replace with function body.

func _process(delta: float) -> void:
	if all_tasks_complete():
		tasks_done = true
		print("All tasks are complete!")
		

func mark_task_complete(task_name):
	if task_name in tasks:
		tasks[task_name] = true
		update_task_list()
		
func update_task_list():
	
	for child in task_container.get_children():
		task_container.remove_child(child)
		child.queue_free()
	
	for task in tasks:
		if task == "Watch TV" and not tasks["Investigate"]:
			continue
		if task == "Try the 
	front door" and not tasks["Watch TV"]:
			continue
		if task == "Follow the
	whispers" and not tasks["Try the 
	front door"]:
			continue
		if task == "Leave this 
	world" and not tasks["Follow the
	whispers"]:
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
	
	if tasks.has("Follow the
	whispers") and tasks["Try the 
	front door"]:
		escape.visible = true
	else:
		escape.visible = false
	

func all_tasks_complete() -> bool:
	for value in tasks.values():
		if not value:
			return false
	return true
