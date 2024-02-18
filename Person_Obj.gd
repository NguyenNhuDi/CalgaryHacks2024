extends Node

class_name Person

var pName: String
var age: int
var income: int
var happiness: float
var rName: String
var mDir: int = 1
var mVec: float = 0.5

func _init(n:String, a:int, i:int, h:float):
	pName = n
	age = a
	income = i
	happiness = h
	rName = "null"
	
