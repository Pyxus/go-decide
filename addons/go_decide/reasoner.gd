class_name Reasoner
extends RefCounted

var _action_groups: Array[ActionGroup]

func decide(context: Context) -> Action:
	return _decide_impl(context)


func create_group(weight: float = 1.0) -> ActionGroup:
	var bucket = ActionGroup.new()
	bucket.weight = weight
	_action_groups.append(bucket)
	sort_groups()
	return bucket


func sort_groups() -> void:
	_action_groups.sort_custom(func(a: ActionGroup, b: ActionGroup): return a.weight < b.weight)

func test(a):
	return 0.0

func _decide_impl(context: Context) -> Action:
	for group in _action_groups:
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