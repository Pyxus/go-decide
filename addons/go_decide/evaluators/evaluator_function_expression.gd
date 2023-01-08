@tool
class_name EvaluatorFunctionExpression
extends EvaluatorFunction

@export var expression: String = "x":
	set(value):
		expression = value
		_parse_error = _exp.parse(expression, ["x"])
		_expression_error = _exp.get_error_text()
		_update_curve()

var expression_error: String:
	get: return _expression_error
	set(value):
		push_warning("This value is read-only")	

var _exp := Expression.new()
var _expression_error: String
var _parse_error := 1

func _init():
	super._init()
	expression = expression


func _get_property_list() -> Array:
	var properties: Array = []
	
	var usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_READ_ONLY
	if _expression_error.is_empty():
		usage |= PROPERTY_USAGE_NO_EDITOR

	properties.append({
		"name": "expression_error",
		"type": TYPE_STRING,
		"usage": usage,
		"hint": PROPERTY_HINT_MULTILINE_TEXT,
	})

	return properties

func _evaluate_impl(input: float) -> float:
	if _parse_error == OK and not expression.is_empty():
		var result = _exp.execute([input], self, false)
		return 0.0 if _exp.has_execute_failed() else result

	return 0.0