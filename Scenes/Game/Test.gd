extends Node2D

# Editor Variables
# ==============================
export var alien_count : int = 5
export var alien_scene : PackedScene

# Internal Variables
# ==============================
var aliens = []
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

  spawn_aliens()

func _update() -> void:
  pass

# Helper Methods
# ==============================
func spawn_aliens() -> void:
  for i in range(alien_count):
    var spawn_position = Vector2(rand_range(min_pos.x + 64, max_pos.x - 64), rand_range(min_pos.y + 64, max_pos.y - 64))
    var new_alien = alien_scene.instance()
    new_alien.position = spawn_position
    aliens.append(new_alien)
    $World/Aliens.add_child(new_alien)

# Note: rotation is not taken into account here. An improvement would be
# to use the inverse transform instead of this.

# Signal Events
# ==============================