extends Node2D

# Editor Variables
# ==============================
export var alien_count : int = 5
export var alien_scene : PackedScene

# Internal Variables
# ==============================
var aliens = []
var min_pos
var max_pos

# Lifecycle Methods
# ==============================
func _ready() -> void:
  min_pos = Vector2(-40,-40)
  max_pos = Vector2(40,40)

  spawn_aliens()

func _update() -> void:
  pass

# Helper Methods
# ==============================
func spawn_aliens() -> void:
  for i in range(alien_count):
    var spawn_position = Vector2(rand_range(min_pos.x, max_pos.x), rand_range(min_pos.y, max_pos.y))
    var new_alien = alien_scene.instance()
    new_alien.position = Vector2()
    aliens.append(new_alien)
    add_child(new_alien)

# Note: rotation is not taken into account here. An improvement would be
# to use the inverse transform instead of this.

# Signal Events
# ==============================