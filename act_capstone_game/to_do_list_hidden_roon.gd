extends Control

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
