extends Node2D
var Person_Obj = preload("res://Person_Obj.gd")

var names = ["Bartu", "Di", "Brett", "Taylor", "Lucy"]
var ages = [13, 34, 45, 66, 21, 25, 66, 99, 101230, 3, 5, 3434]
var incomes = [2333, 21, 4544, 5666, 909, 4343, 95959, 20333]
var happinesses = [0.7, 0.3, 0.4, 0.99, 0.1, 0.12, 0.88, 0.24]



#Returns a list [p1, p2] where p1 and p2 are person objects
#GDScript doesnt have tuples so i needed to use list of 2.

func createRandomPerson():
	var names_copy = names.duplicate()
	var ages_copy = ages.duplicate()
	var incomes_copy = incomes.duplicate()
	var happinesses_copy = happinesses.duplicate()
	
	var rand_name1 = names_copy.pop_at(randi_range(0, len(names_copy) - 1))
	var rand_age1 = ages_copy.pop_at(randi_range(0, len(ages_copy) - 1))
	var rand_income1 = incomes_copy.pop_at(randi_range(0, len(incomes_copy) - 1))
	var rand_happiness1 = happinesses_copy.pop_at(randi_range(0, len(happinesses_copy) - 1))
	
	var rand_name2 = names_copy.pop_at(randi_range(0, len(names_copy) - 1))
	var rand_age2 = ages_copy.pop_at(randi_range(0, len(ages_copy) - 1))
	var rand_income2 = incomes_copy.pop_at(randi_range(0, len(incomes_copy) - 1))
	var rand_happiness2 = happinesses_copy.pop_at(randi_range(0, len(happinesses_copy) - 1))
	
	
	
	
	var p1 = Person_Obj.new(rand_name1, rand_age1, rand_income1, rand_happiness1)  
	var p2 = Person_Obj.new(rand_name2, rand_age2, rand_income2, rand_happiness2)  
	
	return [p1, p2]

var happiness = 33.33
var money = 10

func _on_button_pressed():
	
	var two_people = createRandomPerson()
	
	print("P1 attributes:")
	print("Name: ", two_people[0].pName)
	print("Age: ", two_people[0].age)
	print("Income: ", two_people[0].income)
	print("Happiness: ", two_people[0].happiness)
	
	print("\n\n\n")
	
	print("P2 attributes:")
	print("Name: ", two_people[1].pName)
	print("Age: ", two_people[1].age)
	print("Income: ", two_people[1].income)
	print("Happiness: ", two_people[1].happiness)
	
	print("\n\n\n")
	
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
	
var p1 :Person
var p2 :Person
func _on_show_pop_pressed():
	var control = $PopUpPeople
	var GenButton = $GenPerson
	var ShowButton = $ShowPop
	
	GenButton.visible = false
	ShowButton.visible = false	
	
	control.visible = true
	
	var two_people = createRandomPerson()
	
	var Person1 = $PopUpPeople/Person1
	Person1.text = "P1 attributes:\n" + "Name: " + two_people[0].pName + "\nAge: " + str(two_people[0].age) + "\nIncome: " + str(two_people[0].income) + "\nHappiness: " + str(two_people[0].happiness)
	
	var Person2 = $PopUpPeople/Person2
	Person2.text = "P2 attributes:\n" + "Name: " + two_people[1].pName + "\nAge: " + str(two_people[1].age) + "\nIncome: " + str(two_people[1].income) + "\nHappiness: " + str(two_people[1].happiness)
	
	p1 = two_people[0]
	p2 = two_people[1]
	

func _on_exit_pressed():
	var control = $PopUpPeople
	var GenButton = $GenPerson
	var ShowButton = $ShowPop
	
	GenButton.visible = true
	ShowButton.visible = true	
	control.visible = false


func _on_choose_1_pressed():
	store_person_in_room(p1, "room_2")
	_on_exit_pressed()


func _on_choose_2_pressed():
	store_person_in_room(p2, "room_2")
	_on_exit_pressed()



func _on_room_1_pressed():
	var r1 = "room_1"
	var person = rooms[r1]
	
	print("Name: ", person.pName)
