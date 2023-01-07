class_name Reasoner
extends RefCounted

const _Bucket = preload("bucket.gd")
const _EMPTY_STRING_NAME_ARRAY: Array[StringName] = []

# Type: Dictionary[StringName, Action]
var _action_by_name: Dictionary

# Type: Dictionary[StringName, Bucket]
var _bucket_by_name: Dictionary


func decide(context: Dictionary) -> Action:
	var buckets = _bucket_by_name.values().sort_custom(
		func(a: _Bucket, b: _Bucket):
			return a.weight < b.weight
	)

	for bucket in buckets:
		bucket.update_action_utility()
		var actions: Array[Action] = bucket.actions.filter(func(action): return action.cached_utility == 0.0)
		var sum_utility: float = actions.reduce(func(action): return action.cached_utility)
		var rand_num := randf_range(0, sum_utility)

		for action in actions:
			rand_num -= action.cached_utility

			if rand_num <= 0:
				return action

	return null
		

func add_action(action_name: StringName, action: Action, buckets: Array[StringName] = _EMPTY_STRING_NAME_ARRAY) -> void:
	if _action_by_name.has(action_name):
		push_warning("Failed to add action. Action with name %s already exists" % action_name)
		return
	
	_action_by_name[action_name] = action
	
	for bucket in buckets:
		add_action_to_bucket(action_name, bucket)


func remove_action(action_name: StringName) -> void:
	if _action_by_name.has(action_name):
		for bucket_name in _bucket_by_name:
			remove_action_from_bucket(action_name, bucket_name)

		_action_by_name.erase(action_name)


func add_action_to_bucket(action_name: StringName, bucket_name: StringName) -> void:
	if _action_by_name.has(action_name):
		if not _bucket_by_name.has(bucket_name):
			_bucket_by_name[bucket_name] = _Bucket.new()
		_bucket_by_name[bucket_name].actions[action_name] = true


func remove_action_from_bucket(action_name: StringName, bucket_name: String) -> void:
	if _bucket_by_name.has(action_name):
		var bucket: _Bucket = _bucket_by_name[bucket_name]
		if bucket.actions.has(action_name):
			pass

	