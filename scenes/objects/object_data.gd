class_name ObjectData
extends Node

static func get_tree_sprite_by_id(id=0):
	var trees:Array = [
		"res://art/godot-2d-topdown-rpg-sprites/plants/trees/" + \
				"normal_tree.png",
		"res://art/godot-2d-topdown-rpg-sprites/plants/trees/" + \
				"normal_tree_2.png",
		"res://art/godot-2d-topdown-rpg-sprites/plants/trees/" + \
				"tree_no_leaves.png"
	]
	
	return trees[id]
