extends Node

func _input(event: InputEvent) -> void:
  if event.is_action_pressed("pause"):
    var pause_state = !get_tree().paused
    get_tree().paused = pause_state
    $Pause.visible = pause_state
    $Controls.visible = !pause_state