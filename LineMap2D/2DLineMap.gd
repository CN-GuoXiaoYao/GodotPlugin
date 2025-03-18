@tool
extends EditorPlugin

func _enter_tree() -> void:
	var icon = get_editor_interface().get_editor_theme().get_icon("Line2D", "EditorIcons")
	add_custom_type("LineMap2D", "Line2D", preload("res://addons/2DLineMap/src/LineMap2D.gd"),icon)
	pass


func _exit_tree() -> void:
	remove_custom_type("LineMap2D")
	pass
