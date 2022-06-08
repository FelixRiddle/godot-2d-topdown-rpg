extends KinematicBody2D

# TODO:
# [] Movement
# [] Exp system
# [] Attributes(vitality, endurance, agility, intelligence, etc)

var ObjectUtils = preload("res://godot-libs/libs/utils/object_utils.gd")
var input_handler = preload("res://godot-libs/inputs/" +
	"input_handler.gd").new({ "disable_wasd": false,
	"disable_arrows": false, "disable_joystick": false, })

onready var anim_player:AnimationPlayer = $AnimationPlayer
onready var hotbar = $InventoryManager/HotbarV2 setget set_hotbar, get_hotbar
onready var inv_mng:InventoryManager = $InventoryManager
onready var inv_ui = $InventoryManager/InventoryV2 \
		setget set_inv_ui, get_inv_ui
onready var inv_timer:Timer = $InventoryVisibleStateTimer
onready var attack_timer:Timer = $AttackTimer

export(float) var attack_delay:float = 1.0
export(float) var inv_delay:float = 0.1
export(int) var speed:int = 200

var debug = true setget set_debug, get_debug
var velocity = Vector2.ZERO

# Physics process tries to perform operations at a constant framerate
func _physics_process(delta):
	get_input()
	
	# Check if the user opened or closed the inventory
	update_inventory_visible_state()
	
	has_attacked()
	
	velocity = move_and_slide(velocity)


func attack():
	var anim_list = anim_player.get_animation_list()
	
	for anim_name in anim_list:
		match(anim_player.current_animation):
			"WalkDown":
				anim_player.play("AttackDown")
			"WalkUp":
				anim_player.play("AttackUp")
			_:
				continue


func get_attack_input() -> bool:
	# 1 = Left mouse button
	if(Input.is_mouse_button_pressed(1)):
		return true
		
		# Then second argument is Gamepad button 0 or DualShock X button or
		# Nintendo B button or Xbox A button
	elif(Input.is_joy_button_pressed(0, 0)):
		return true
	return false


# Change velocity depending on the player input, it's normalized, so that
# when the player presses 2 keys, it doesn't add up velocity
func get_input():
	velocity = Vector2()
	if(input_handler.right()):
		velocity.x += 1
		anim_player.current_animation = "WalkRight"
	if(input_handler.left()):
		velocity.x -= 1
		anim_player.current_animation = "WalkLeft"
	if(input_handler.up()):
		velocity.y -= 1
		anim_player.current_animation = "WalkUp"
	if(input_handler.down()):
		velocity.y += 1
		anim_player.current_animation = "WalkDown"
	
	# With normalize we prevent the player from having
	# extra speed while moving diagonally
	velocity = velocity.normalized() * speed


func has_attacked():
	# We need a cooldown for this one too
	if(get_attack_input() && attack_timer.is_stopped()):
		if(debug):
			print("Player has attacked!")
		attack()
		
		attack_timer.start()


# setget debug
func set_debug(value:bool) -> void:
	debug = value
func get_debug() -> bool:
	return debug


# setget inv_ui
func set_hotbar(value) -> void:
	hotbar = value
func get_hotbar():
	return hotbar


# setget inv_ui
func set_inv_ui(value) -> void:
	inv_ui = value
func get_inv_ui():
	return inv_ui


# Open or close the inventory
func update_inventory_visible_state():
	var is_inv_key_pressed = false
	
	if(Input.is_physical_key_pressed(KEY_I)):
		is_inv_key_pressed = true
		# The first argument is the device connected)?
		# JOY_L3 = 8 (Left stick click)
	elif(Input.is_joy_button_pressed(0, 8)):
		is_inv_key_pressed = true
	
	# The player pressed the key to open or close inv
	if(is_inv_key_pressed && inv_timer.is_stopped()):
		# If the inventory is open close it, otherwise open it
		self.inv_ui.visible = !self.inv_ui.visible
		
		# Start the timer(if not it would open and close
		# every frame the keys are pressed)
		inv_timer.start(inv_delay)


func _on_ObjectDetector_body_entered(body):
	print("Body: ", body)
	print("It's name: ", body.name)
