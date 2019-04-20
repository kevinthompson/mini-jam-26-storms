extends Node

func change_scene(scene : PackedScene, transition : bool = true):
  call_deferred("_deferred_change_scene", scene, transition)

func _deferred_change_scene(scene : PackedScene, transition : bool = true):
  var container = get_tree().get_root().get_node("/root/Main/SceneContainer")
  for node in container.get_children():
    node.free()
  container.add_child(scene.instance())