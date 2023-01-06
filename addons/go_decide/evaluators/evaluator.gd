class_name Evaluator
extends Resource

func evaluate(score: float) -> float:
    return evaluate_impl(score)


func evaluate_impl(score: float) -> float:
    return score