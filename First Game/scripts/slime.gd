extends Node2D

const SPEED = 60

var direction = 1
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1 
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta 
	
	
# Enemy properties
var health: int
var max_health: int

# Called when the node enters the scene tree for the first time.
func _ready():
	max_health = 100
	health = max_health

# Function to handle taking damage
func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		die()

# Function to handle enemy death
func die() -> void:
	# Add death animation or effects here
	queue_free() # Removes the enemy from the scene

# Example of how to call take_damage
func _on_Hitbox_body_entered(body: Node) -> void:
	if body.name == "Player":
		take_damage(10) # Example damage amount

