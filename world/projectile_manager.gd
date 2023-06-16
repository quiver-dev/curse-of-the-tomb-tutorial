extends Node


var torch = preload("res://entities/archaeologist/torch.tscn")
var flames = preload("res://entities/archaeologist/flames.tscn")
var sword = preload("res://entities/henchman/sword.tscn")


func initialize(enemies: Array[Node]):
	for enemy in enemies:
		if enemy.has_signal("torch_thrown"):
			enemy.torch_thrown.connect(handle_torch_thrown)
		if enemy.has_signal("sword_dropped"):
			enemy.sword_dropped.connect(handle_sword_dropped)


func handle_torch_thrown(location: Vector2, direction: float):
	var torch_instance = torch.instantiate()
	add_child(torch_instance)
	torch_instance.initialize(location, direction)
	torch_instance.torch_collided.connect(handle_torch_collided)


func handle_torch_collided(location: Vector2):
	var flames_instance = flames.instantiate()
	flames_instance.global_position = location
	call_deferred("add_child", flames_instance)


func handle_sword_dropped(location: Vector2):
	var sword_instance = sword.instantiate()
	sword_instance.global_position = location
	add_child(sword_instance)
