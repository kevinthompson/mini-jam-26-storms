extends Node2D

# Editor Variables
# ==============================
export var alien_count : int = 5
export var alien_scene : PackedScene

# Internal Variables
# ==============================
var aliens = []

# Lifecycle Methods
# ==============================
func _ready() -> void:
  spawn_aliens()

func _update() -> void:
  pass

# Helper Methods
# ==============================

func spawn_aliens() -> void:
  for i in range(alien_count):
    var spawn_position = Vector2(rand_range(64,960), rand_range(64,536))
    var new_alien = alien_scene.instance()
    new_alien.position = spawn_position
    new_alien.target = spawn_position
    aliens.append(new_alien)
    $World/Aliens.add_child(new_alien)

# Signal Events
# ==============================