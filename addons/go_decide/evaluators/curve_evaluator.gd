class_name CurveEvaluator
extends "evaluator.gd"

## If true uses the curve's baked sample for evaluation
@export var use_baked: bool = true
@export var curve := Curve.new()

func evaluate_impl(score: float) -> float:
    return (
        curve.sample_baked(score) if use_baked 
        else curve.sample(score)
        )