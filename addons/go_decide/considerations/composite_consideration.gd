class_name CompositeConsideration
extends Consideration
## Component based consideration
##
## Takes the average score of all consideration children.

var _root_wf: WeakRef
var _considerations: Array[Consideration]

func _score_impl(context: Context) -> float:
    if _considerations.is_empty():
        return 0.0
    return _considerations.reduce(func(c): return c.score(context)) / _considerations.size()

## Adds a consideration to the composition.
func add_consideration(consideration: Consideration) -> void:
    if consideration is CompositeConsideration:
        if consideration.get_root() == self:
            push_warning("Failed to add consideration. Consideration %s already belongs to this system" % consideration)
            return
        elif consideration.get_root() != null:
            push_warning("Failed to add consideration. Consideration already belongs to another system.")
            return
        
        consideration._root_wf = weakref(get_root())
    
    for c in _considerations:
        if c == consideration:
            push_warning("Failed to add consideration. Consideration %s has already been added." % consideration)
    
    
    _considerations.append(consideration)

## Returns the root of this composite consideration
func get_root() -> Consideration:
    return _root_wf.get_ref() if _root_wf else null