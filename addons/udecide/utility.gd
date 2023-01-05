extends RefCounted

var rank: int
var weight: float

func _init(rank: int, weight: float) -> void:
	self.rank = rank
	self.weight = weight
