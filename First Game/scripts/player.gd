extends CharacterBody2D


const SPEED = 140.0
const JUMP_VELOCITY = -390.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

@export var attacking = false

func _process(delta):
	if Input.is_action_just_pressed("attack"): attack()

func attack():
	attacking = true
	animated_sprite.play("attack1")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta



	if Input.is_action_just_pressed("attack"):
		$AnimatedSprite2D.play("attack1")
		
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	#Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0: 
		animated_sprite.flip_h = true
	
	# Attack Animation
	
	
	
	#Play animations
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("run") 
	else: 
		animated_sprite.play("jump")
	

	#Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
# Path: res://Player.gd

# Player properties
var health: int
var max_health: int
var damage: int
var is_attacking: bool


# Called when the node enters the scene tree for the first time.
func _ready():



	max_health = 100
	health = max_health
	damage = 10 # Example damage value

# Function to handle taking damage
func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
			die()

# Function to handle player death
func die() -> void:
	# Add death animation or effects here
	queue_free() # Removes the player from the scene

# Called when the attack area detects a body
func _on_AttackArea_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)

# Input function to handle attack action


# Function to attack an enemy


# func attack():
	if is_on_floor():
		is_attacking = true
		animated_sprite.play("attack1")
		await animated_sprite.animation_finished
		is_attacking = false
	else:
			return

