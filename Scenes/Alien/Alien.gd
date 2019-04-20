extends KinematicBody2D

# Editor Variables
# ==============================
export var speed := 250
export var initial_happiness := 3
export var emote_visibility_seconds := 3

# Internal Variables
# ==============================
var bouncing = false
var target
var velocity = Vector2()
var happiness : int = 3
var min_happiness : int = 1
onready var max_happiness : int = $Emote.hframes

# Lifecycle Methods
# ==============================
func _ready() -> void:
  # Connect Signals
  $Emote/VisibilityTimer.connect("timeout", self, "_on_emote_visibility_timer_timeout")

  # Initial State
  set_happiness(initial_happiness)

func _process(delta: float) -> void:
  if Input.is_action_pressed("mouse_left_click"):
    target = get_global_mouse_position()
    velocity = (target - position).normalized() * speed
    set_happiness(3)

  if velocity > Vector2.ZERO:
    $AnimationPlayer.play("Walk")
  else:
    $AnimationPlayer.play("Idle")

  if velocity.x < 0:
    $Sprite.flip_h = false
  elif velocity.x > 0:
    $Sprite.flip_h = true

func _physics_process(delta: float) -> void:
  if bouncing:
    velocity = lerp(velocity, (target - position).normalized() * speed, .01)

  if target:
    if (target - position).length() <= 5:
      set_happiness(max_happiness)

    if (target - position).length() > 5:
      var collision = move_and_collide(velocity * delta)

      if collision:
        decrease_happiness()
        bouncing = true
        velocity = velocity.bounce(collision.normal)
    else:
      velocity = Vector2.ZERO

# Helper Methods
# ==============================
func increase_happiness() -> void:
  var new_value = min(happiness + 1, max_happiness)
  set_happiness(new_value)

func decrease_happiness() -> void:
  var new_value = max(happiness - 1, min_happiness)
  set_happiness(new_value)

func set_happiness(value : int, visible : bool = true) -> void:
  if happiness != value:
    $Emote/VisibilityTimer.stop()
    happiness = value
    $Emote.frame = $Emote.hframes - happiness
    $Emote.visible = visible
    $Emote/VisibilityTimer.start(emote_visibility_seconds)

# Signal Events
# ==============================
func _on_emote_visibility_timer_timeout() -> void:
  $Emote.visible = false