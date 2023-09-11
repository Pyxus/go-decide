@tool
class_name EvaluatorFunction
extends Evaluator

## This curve resource is only intended for visulization in the editor.
## Since the visualization uses discrete points it will not 100% match
## the underlying math function.
@export var _curve_visualizer: Curve

var _curve_generator: _CurveGenerator

func _init() -> void:
	if Engine.is_editor_hint():
		_curve_generator = _CurveGenerator.new()
		_curve_visualizer = _curve_generator.curve
		_update_curve()


func _update_curve() -> void:
	if Engine.is_editor_hint():
		_curve_generator.update(_evaluate_impl, invert)


func _invert_updated() -> void:
	_update_curve()


class _CurveGenerator:
	var curve := Curve.new()
	var increment := 0.1
	
	func update(function: Callable, invert: bool = false) -> void:
		curve.clear_points()

		var x := 0.0
		while x < 1:
			var y: float = 1 - function.call(x) if invert else function.call(x)
			curve.add_point(Vector2(x, y), 0, 0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
			x += increment
