@tool
class_name CurveEvaluator
extends Evaluator

## If true uses the curve's baked sample for evaluation
@export var use_baked: bool = true
@export var curve := Curve.new()

func evaluate_impl(value: float) -> float:
    return (
        curve.sample_baked(value) if use_baked 
        else curve.sample(value)
        )