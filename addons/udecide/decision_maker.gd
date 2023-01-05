extends Node

const _Bucket = preload("bucket.gd")
const _EMPTY_STRING_NAME_ARRAY: Array[StringName] = []

# Type: Dictionary[StringName, Action]
var _action_by_name: Dictionary

# Type: Dictionary[StringName, Bucket]
var _bucket_by_name: Dictionary


func add_action(action_name: StringName, action: Action, buckets: Array[StringName] = _EMPTY_STRING_NAME_ARRAY) -> void:
	if _action_by_name.has(action_name):
		push_warning("Failed to add action. Action with name %s already exists" % action_name)
		return
	
	_action_by_name[action_name] = action
	
	for bucket in buckets:
		add_action_to_bucket(action_name, bucket)


func add_action_to_bucket(action_name: StringName, bucket_name: StringName) -> void:
	if _action_by_name.has(action_name):
		if not _bucket_by_name.has(bucket_name):
			_bucket_by_name[bucket_name] = _Bucket.new()
		_bucket_by_name[bucket_name].actions[action_name] = true