class_name CompositeConsideration
extends Consideration
## Component based consideration
##
## Takes the average score of all consideration children.

func _score_impl(context: Context) -> float:
    if not has_child_considerations():
        return 0.0
    
    var considerations := get_considerations()
    return considerations.reduce(func(c): return c.score(context)) / considerations.size()


func has_child_considerations() -> bool:
    for child in get_children():
        if child is Consideration:
            return true
    return false


func get_considerations() -> Array[Consideration]:
    return get_children().filter(func(node): return node is Consideration)
