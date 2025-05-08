class_name ToDoList extends Control
@onready var mirror: Sprite2D = $"../QuestionMarks/Mirror"
@onready var tasks_done = false

var tasks = {
	"Have meal": false,
	"Water plants(3)": false,
	"Use Computer": false,
	"Check mirror": false,
	"Go to bed": false
}
@onready var task_container: VBoxContainer = $CanvasLayer/VBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mirror.visible = false
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
		if task == "Check mirror" and not tasks["Use Computer"]:
			continue
		mirror.visible = true
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

	if tasks.has("Check mirror") and tasks["Use Computer"]:
		mirror.visible = true
	else:
		mirror.visible = false
		
	if tasks["Check mirror"]:
		mirror.visible = false

func all_tasks_complete() -> bool:
	for task in tasks:
		if task == "Go to bed":
			continue
		if not tasks[task]:
			return false
	return true
