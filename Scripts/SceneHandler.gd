extends Node


var main_menu_scene : PackedScene = preload("res://Scenes/UIScenes/MainMenu.tscn")


func _ready():
	var main_menu_instance := main_menu_scene.instantiate()
	add_child(main_menu_instance)
