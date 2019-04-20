extends Control

func _input(event: InputEvent) -> void:
  if event.is_action_pressed("pause"):
    var pause_state = !get_tree().paused
    get_tree().paused = pause_state
    visible = pause_state