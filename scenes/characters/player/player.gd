extends KinematicBody2D

# TODO:
# [] Movement
# [] Exp system
# [] Attributes(vitality, endurance, agility, intelligence, etc)

onready var inv_mng:InventoryManager = $InventoryManager

export (int) var speed = 200

var input_handler = preload("res://godot-libs/inputs/" +
	"input_handler.gd").new({ "disable_wasd": false,
	"disable_arrows": false, "disable_joystick": false, })
var inv setget set_inv, get_inv
var inv_ui setget set_inv_ui, get_inv_ui
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.inv_mng.set_info({ "debug": true })
	
	# The inventory gets added to the inventory_manager and is set to
	# inv_ui variable
	self.inv_ui = self.inv_mng.add_inventory_scene(
			load("res://godot-libs/inventory_ui/inventory/inventory.tscn"))
	
	# Change ui visibility to false, so it doesn't start with the inventory
	# open
	self.inv_ui.set_info({ "debug": true, "visible": true, })
	
	# Get a reference to the inventory script that contains the items
	self.inv = self.inv_ui.cells_manager.inventory
	
	# Set the InventoryUI size/length
	self.inv_ui.cells_manager.length = 45


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Physics process tries to perform operations at a constant framerate
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)


# Change velocity depending on the player input, it's normalized, so that
# when the player presses 2 keys, it doesn't add up velocity
func get_input():
	velocity = Vector2()
	if(input_handler.right()):
		velocity.x += 1
	if(input_handler.left()):
		velocity.x -= 1
	if(input_handler.up()):
		velocity.y -= 1
	if(input_handler.down()):
		velocity.y += 1
	
	# With normalize we prevent the player from having
	# extra speed while moving diagonally
	velocity = velocity.normalized() * speed


# setget inv_ui
func set_inv(value) -> void:
	inv = value
func get_inv():
	return inv


# setget inv_ui
func set_inv_ui(value) -> void:
	inv_ui = value
func get_inv_ui():
	return inv_ui
