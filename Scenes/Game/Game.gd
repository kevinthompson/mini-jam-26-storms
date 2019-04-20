extends Node2D

# Editor Variables
# ==============================
export var tribe_count : int = 5
export var tribe_scene : PackedScene

# Internal Variables
# ==============================
var tribes = []
onready var screen_width = get_viewport().size.x
onready var screen_height = get_viewport().size.y
var min_pos
var max_pos

# Lifecycle Methods
# ==============================
func _ready() -> void:
  var ctrans = get_canvas_transform()
  var view_size = get_viewport_rect().size / ctrans.get_scale()

  min_pos = -ctrans.get_origin() / ctrans.get_scale()
  max_pos = min_pos + view_size

  spawn_tribes()

func _update() -> void:
  pass

# Helper Methods
# ==============================
func spawn_tribes() -> void:
  for i in range(tribe_count):
    var spawn_position = Vector2(rand_range(min_pos.x + 64, max_pos.x - 64), rand_range(min_pos.y + 64, max_pos.y - 64))
    var new_tribe = tribe_scene.instance()
    new_tribe.position = spawn_position
    tribes.append(new_tribe)
    $World/Tribes.add_child(new_tribe)

# Note: rotation is not taken into account here. An improvement would be
# to use the inverse transform instead of this.

# Signal Events
# ==============================