# enemy_melee.gd
# This script controls the behaviour of a melee enemy. It handles movement,
# attacking, and taking damage. The enemy will chase the player when they are
# within detection range and attack when they are close enough.
extends CharacterBody2D

## The speed at which the enemy moves towards the player, measured in pixels per second.
## Higher values make the enemy faster, while lower values make it slower.
@export var move_speed: float = 120.0

## The distance within which the enemy will detect the player.
@export var detection_range: float = 300.0

## The cooldown between attacks, in seconds.
@export var attack_cooldown: float = 1.2

@export var max_health: int = 40

# Reference to the player node, which we will use to track the player's position.
var player: Node2D = null

var health: int = max_health

# This variable keeps track of the remaining time before the enemy can attack again.
# It is decreased every physics frame and when it reaches zero, the enemy can attack.
var _cooldown_left: float = 0.0
var _flash_timer: float = 0.0

#var _debug_draw := true

func _physics_process(delta: float) -> void:
	# First, we check whether the player exists. If it does not, we return early
	# because there is nothing to chase.
	if player == null:
		return

	# Decrease the cooldown timer by the elapsed time.
	_cooldown_left = max(_cooldown_left - delta, 0.0)

	var to_player := player.global_position - global_position
	if to_player.length() > detection_range:
		velocity = Vector2.ZERO
	else:
		# Move towards the player by normalizing the direction vector and
		# multiplying it by the move speed.
		velocity = to_player.normalized() * move_speed
	move_and_slide()

	if to_player.length() < 40.0:
		_try_attack()

func _try_attack() -> void:
	# The attack animation uses root motion, so attacking in the air slides the
	# enemy off ledges.
	if _cooldown_left > 0.0 or not is_on_floor():
		return
	_cooldown_left = attack_cooldown
	$AnimationPlayer.play("attack")

## Applies damage to the enemy. This function takes an amount of damage and
## subtracts it from the enemy's health. If the health drops to zero or below,
## the enemy dies. It also plays a hit flash effect to give the player feedback.
## @param amount The amount of damage to apply.
func take_damage(amount: int) -> void:
	health -= amount
	_flash_timer = 0.1  # Set the flash timer to 0.1 seconds.
	if health <= 0:
		# The enemy has no health left, so we call the die function to handle death.
		_die()

func _die() -> void:
	queue_free()
