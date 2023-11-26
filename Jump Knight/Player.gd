extends KinematicBody2D

const UP = Vector2(0,-1)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed = 280

var rng = RandomNumberGenerator.new()

var velocity = Vector2()
const GRAVITY = 20
const MAX_GRAVITY = 2000
var jumping = false
var stunned = false

var storedJump = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

func jump():
	$AnimatedSprite.play("Jump")
	if storedJump < -950:
		storedJump = -950
	velocity.y = storedJump
	storedJump = 0
	jumping = true

func _physics_process(delta):
	if(velocity.y < MAX_GRAVITY):
		velocity.y += GRAVITY
	
	if is_on_floor() && !jumping && !stunned:
		if Input.is_action_pressed("right"):
			$AnimatedSprite.flip_h = false 
			velocity.x = speed
		elif Input.is_action_pressed("left"):
			$AnimatedSprite.flip_h = true
			velocity.x = -speed
		else:
			velocity.x = 0
		if Input.is_action_pressed("jump"):
			velocity.x = 0
			storedJump -= 40
			$AnimatedSprite.play("PreJump")
		if Input.is_action_just_released("jump"):
			$JumpSound.play()
			jump()
	var prev_velocity = velocity
	velocity = move_and_slide(velocity, UP, false, 4, 0.20)
	if prev_velocity.length() > 300 && jumping && !stunned:
		if get_slide_count() > 0:
			if !is_on_floor():
				velocity = prev_velocity.bounce(get_slide_collision(0).normal) * 0.8
				$BonkSound.play()
				$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
			else:
				$LandSound.play()
			jumping = false
	if prev_velocity.length() > 1200:
		if get_slide_count() > 0:
			if is_on_floor():
				print("RIP")
				var chance = rng.randi_range(0, 100)
				if(chance==90):
					$OneprctSound.play()
				else:
					$HitSound.play()
				$AnimatedSprite.play("Fallen")
				stunned = true
				velocity.x = 0
				var time_in_seconds = 1.5
				yield(get_tree().create_timer(time_in_seconds), "timeout")
				print("IM OK")
				$AnimatedSprite.play("Standup")
				stunned = false
			jumping = false
	if is_on_floor():
		jumping = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
