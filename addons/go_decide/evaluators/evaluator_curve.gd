extends "evaluator.gd"

@export var use_baked: bool = true
@export var curve: Curve

func evaluate_impl(score: float) -> float:
    return (
        curve.sample_baked(score) if use_baked 
        else curve.sample(score)
        )