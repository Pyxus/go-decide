class_name EvaluatorCurve
extends Evaluator

## If true uses the curve's baked sample for evaluation
@export var use_baked: bool = true
@export var curve := Curve.new()

func _evaluate_impl(input: float) -> float:
	return (
		curve.sample_baked(input) if use_baked 
		else curve.sample(input)
		)