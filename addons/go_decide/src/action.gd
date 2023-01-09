@tool
class_name Action
extends Node
## Class representing a possible action the AI can take

signal group_changed()

## Weight used to adjust how desireable this action is.[br]
##
## Modifying this value can contribute to personality emulation as it
## affects how much the AI prefers an action regardless of Utility.
@export var weight: float = 1.0

## Value ranging from 0 to 1 which represents how likely the action is to be successfully performed
@export_range(0, 1, .01) var probability: float = 1.0:
	set(value):
		probability = clampf(value, 0, 1)

@export var groups: PackedStringArray:
	set(value):
		groups = value
		notify_property_list_changed()


## Optional description of what the action does
@export_multiline var description: String = ""

## [b]Read Only.[/b] Value representing how desireable this action is.[br]
## This is a read only cached value that is updated whenever [method Action.calc_utility] is called.
var utility: float = 0.0:
	get: return _utility
	set(value): push_warning("This property is read only")

## Function that is invoked if this action is selected.[br]
## Type: () -> void
var execute: Callable

var _utility: float = 0.0


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
	var considerations := get_considerations()
	if considerations.is_empty() or is_zero_approx(weight) or is_zero_approx(probability):
		return 0.0
	
	_utility =  _considerations_weighted_avg(context) * weight * probability
	return _utility


func get_considerations() -> Array[Consideration]:
	var considerations: Array[Consideration]
	
	for node in get_children():
		if node is Consideration:
			considerations.append(node)
	
	return considerations


func _considerations_weighted_avg(context: Context) -> float:
	var sum_weight := 0.0
	var sum_score := 0.0
	
	for c in get_considerations():
		sum_weight += c.weight
		sum_score += c.score(context) * c.weight
	
	if sum_weight == 0.0:
		return 0.0
	
	return sum_score / sum_weight
