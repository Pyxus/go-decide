class_name Action
extends RefCounted
## Class representing a possible action the AI can take

## Value ranging from 0 to 1 which represents how likely the action is to be successfully performed
var probability: float = 1.0:
    set(value):
        probability = clampf(value, 0, 1)

## Weight used to adjust how desireable this action is.[br]
## Weight can be used to emulate personality. A high height will cause the AI to favor this action
## even if it does not have the most utility; the opposite is true for a low weight.
var weight: float = 1.0

## List of considerations for this action.
var considerations: Array[Consideration]

## [b]Read Only.[/b] Value representing how desireable this action is.[br]
## This is a read only cached value that is updated whenever [method Action.calc_utility] is called.
var utility: float = 0.0:
    get: return _utility
    set(value): push_warning("This property is read only")

## Function that is invoked if this action is selected.[br]
## Type: () -> void
var execute: Callable

var _utility: float = 0.0

func _init(considerations: Array[Consideration], execute: Callable) -> void:
    self.considerations = considerations
    self.execute = execute

## Setter for [member Action.weight].
## Returns a reference to this action allowing for chain method calls 
func set_weight(weight: float) -> Action:
    self.weight = weight
    return self

## Setter for [member Action.probability].
## Returns a reference to this action allowing for chain method calls 
func set_probability(probability: float) -> Action:
    self.probability = probability
    return self

## Setter for [member Action.considerations].
## Returns a reference to this action allowing for chain method calls 
func set_considerations(considerations: Array[Consideration]) -> Action:
    self.considerations = considerations
    return self


## Computes this action's utility.
func calc_utility(context: Context) -> float:
    if considerations.is_empty() or is_zero_approx(weight) or is_zero_approx(probability):
        return 0.0

    var avg_score: float = considerations.reduce(func(c): c.score(context)) / considerations.size()
    _utility = avg_score * weight * probability
    return _utility