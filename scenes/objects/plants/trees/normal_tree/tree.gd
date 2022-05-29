tool
extends Node2D

var ObjectData = preload("res://scenes/objects/object_data.gd")

export(float) var opacity_change:float = 0.4 setget set_opacity_change, \
		get_opacity_change
export(int) var tree_id = 0

# Handle object information, like changing the opacity when the player
# is in the area of the object
var obj = preload("res://godot-libs/libs/objects/object.gd")

func _ready():
	var sprite:Sprite = $Sprite
	
	sprite.texture = load(ObjectData.get_tree_sprite_by_id(tree_id))
	
	# Create the object and pass a reference of this node
	obj = obj.new(self)

func set_opacity_change(value) -> void:
	opacity_change = value
func get_opacity_change() -> float:
	return opacity_change
