extends Button

func _pressed() -> void:
  get_tree().change_scene("res://Scenes/Title/TitleScreen.tscn")
  get_tree().paused = false