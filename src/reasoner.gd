@tool
class_name Reasoner
extends Node

var _default_group := _ActionGroup.new("", 0.0)
var _action_groups: Array[_ActionGroup] = []
var _weight_by_group: Dictionary

func _ready() -> void:
	for node in get_children():
		if node is Action:
			_default_group.actions.append(node)
			_update_groups(node)
			sort_groups()


func _set(property: StringName, value) -> bool:
	if _weight_by_group.has(property):
		_weight_by_group[property] = value
		return true
	return false


func _get(property: StringName):
	if _weight_by_group.has(property):
		return _weight_by_group[property]


func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	var group_dict := {}
	
	properties.append({
		"name": "_weight_by_group",
		"type": TYPE_DICTIONARY,
		"usage": PROPERTY_USAGE_NO_EDITOR | PROPERTY_USAGE_STORAGE,
	})
	
	for node in get_children():
		if node is Action:
			for group in node.groups:
				if not group.is_empty() and not group_dict.has(group):
					var prop_name: StringName = "group_weights/%s" % group
					group_dict[prop_name] = 0.0
					properties.append({
						"name": prop_name,
						"type": TYPE_FLOAT,
						"usage": PROPERTY_USAGE_DEFAULT,
					})
	
	var dup_dict := _weight_by_group.duplicate()
	_weight_by_group.clear()
	
	for key in group_dict:
		_weight_by_group[key] = dup_dict[key] if dup_dict.has(key) else 0.0
		
	return properties


func decide(context: Context) -> Action:
	return _decide_impl(context)


func get_action(action_name: String) -> Action:
	for node in get_children():
		if node is Action and node.name == action_name:
			return node
	return null
	
	
func sort_groups() -> void:
	_action_groups.sort_custom(func(a: _ActionGroup, b: _ActionGroup): return a.weight < b.weight)


func _decide_impl(context: Context) -> Action:
	for group in _action_groups + [_default_group]:
		group.update_action_utility(context)
		var actions: Array[Action] = group.actions
		var sum_utility:= 0.0

		for action in actions:
			sum_utility += action.utility

		var rand_num := randf_range(0, sum_utility)

		for action in actions:
			rand_num -= action.utility

			if rand_num <= 0:
				return action

	return null


func _update_groups(action: Action) -> void:
	# Add action to groups or generate them if they don't exist
	for group_name in action.groups:
		if not group_name.is_empty():
			var found_group := false

			for group in _action_groups:
				if group.name == group_name:
					if not group.has(action):
						group.append(action)
					found_group = true
			
			if not found_group:
				var group := _ActionGroup.new(group_name)
				group.actions.append(action)
				_action_groups.append(group)

	# Remove action from groups it is no longer member to
	for group in _action_groups:
		if group.actions.has(action) and not action.groups.has(group.name):
			group.actions.erase(action)

	_action_groups = _action_groups.filter(func(g): return g.actions.is_empty())


class _ActionGroup:
	extends RefCounted


	## Group weight. Groups with a higher weight are evaluated first by the [class Reasoner]
	var weight: float = 1.0

	var name: StringName = ""

	var actions: Array[Action]

	func _init(name: String = "", weight: float = 1.0) -> void:
		self.name = name
		self.weight = weight

	func update_action_utility(context: Context) -> void:
		for action in actions:
			action.calc_utility(context)
