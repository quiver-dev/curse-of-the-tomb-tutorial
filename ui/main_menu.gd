extends CanvasLayer


@onready var save_button_1 = %SaveButton1
@onready var save_button_2 = %SaveButton2
@onready var save_button_3 = %SaveButton3


func _ready() -> void:
	save_button_1.initialize_button("save_1")
	save_button_2.initialize_button("save_2")
	save_button_3.initialize_button("save_3")
