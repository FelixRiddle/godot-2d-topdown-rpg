class_name ObjectData
extends Node

# Tree sprites
static func get_tree_sprites() -> Array:
	return [
		"res://art/godot-2d-topdown-rpg-sprites/png/plants/" + \
				"trees/normal_tree.png",
		"res://art/godot-2d-topdown-rpg-sprites/png/plants/" + \
				"trees/normal_tree_2.png",
		"res://art/godot-2d-topdown-rpg-sprites/png/plants/" + \
				"trees/tree_no_leaves.png",
	]

static func get_tree_sprite_by_id(id=0):
	var trees:Array = get_tree_sprites()
	return trees[id]

# Bush sprites
static func get_bush_sprites() -> Array:
	return [
		"res://art/godot-2d-topdown-rpg-sprites/png/plants/bushes/bush1.png",
		"res://art/godot-2d-topdown-rpg-sprites/png/plants/bushes/bush2.png",
	];

static func get_bush_sprite_by_id(id=0):
	var bushes:Array = get_bush_sprites()
	return bushes[id]
