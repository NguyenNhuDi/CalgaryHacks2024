extends Node2D
var Person_Obj = preload("res://Person_Obj.gd")

var rooms = {}
var fPerson = Person_Obj.new("null", -1, -1, 0)


func store_person_in_room(person:Person, room:String):
	assert(room in rooms, "%s not in rooms" % [room])
	
	rooms[room] = person
	person.rName = room

func remove_person_in_room(room:String):
	assert(room in rooms, "%s not in rooms" % [room])
	rooms[room] = fPerson

func _ready():
	# initialize rooms:
	for i in range(6):
		var rName = "room_%d" % [i]
		rooms[rName] = fPerson
		
	var b2 = Person_Obj.new("Bartu", 21, 2000, 0.001)
	
	store_person_in_room(b2, "room_2")
	
	print("Person in room_2:")
	print(rooms["room_2"].pName)
	
	print("removing person...")
	remove_person_in_room("room_2")
	
	print("Person in room_2:")
	print(rooms["room_2"].pName)
	
	remove_person_in_room("room_10")
	
		
