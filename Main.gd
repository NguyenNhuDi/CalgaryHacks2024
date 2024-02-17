extends Node2D
var Person_Obj = preload("res://Person_Obj.gd")

var happiness = 33.33
var money = 10

func _on_button_pressed():
	var p1 = Person_Obj.new("B2", 21, 2000, 5)
	
	print("Bartu attributes")
	print(p1.age)
	print(p1.income)
	print(p1.happiness)
	print(p1.pName)


