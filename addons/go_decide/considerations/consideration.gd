class_name Consideration
extends Resource
## Abstract base class of all considerations
##
## Represents a decision factor which encapsulates one aspect of a larger factor.

## Evaluator used to map raw consideration value to desirability score.[br]
##
## For example, when considering health for a heal action
## the lower your health the more desireable it is to heal.
## Therefore the lower your health value the larger the evaluator's return value should be.
@export var evaluator := Evaluator.new()

## Returns the desireability score of this consideration.
func score(context: Context) -> float:
    var value := _get_value_impl(context)

    if not value in range(0, 1):
        push_warning("Consideration values should be normalized from 0 to 1.")

    return evaluator.evaluate(value)


func _get_value_impl(context: Context) -> float:
    push_error("Method not implemnted!")
    return 0.0