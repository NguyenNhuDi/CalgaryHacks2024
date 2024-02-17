extends Node2D
var Person_Obj = preload("res://Person_Obj.gd")

var rooms = {}

func store_person_in_room(person:Person, room:String):
	rooms[room] = person

func _ready():
	var fPerson = Person_Obj.new("null", -1, -1, 0)
	# initialize rooms:
	for i in range(6):
		var rName = "room_%d" % [i]
		rooms[rName] = fPerson
		
