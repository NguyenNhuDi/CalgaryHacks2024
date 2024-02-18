extends Node2D
var Person_Obj = preload("res://Person_Obj.gd")


var name_path = {"Bartu": "res://assets/Characters/tile000.png", "Di":"res://assets/Characters/tile001.png", "Brett":"res://assets/Characters/tile002.png", "Taylor":"res://assets/Characters/tile003.png", "Lucy":"res://assets/Characters/tile005.png", "Emma":"res://assets/Characters/tile007.png", "Liam":"res://assets/Characters/tile004.png", "Olivia":"res://assets/Characters/tile016.png", "Noah": "res://assets/Characters/tile006.png", "Ava": "res://assets/Characters/tile019.png", "William": "res://assets/Characters/tile008.png", "James": "res://assets/Characters/tile009.png", "Benjamin": "res://assets/Characters/tile010.png", "Elijah": "res://assets/Characters/tile011.png", "Lucas": "res://assets/Characters/tile012.png", "Andrew": "res://assets/Characters/tile013.png", "Joshua": "res://assets/Characters/tile014.png", "Nicholas": "res://assets/Characters/tile015.png", "Ryan": "res://assets/Characters/tile017.png", "Tyler": "res://assets/Characters/tile018.png"}
var names = ["Bartu", "Di", "Brett", "Taylor", "Lucy", "Emma", "Liam", "Olivia", "Noah", "Ava", "William", "James", "Benjamin", "Elijah", "Lucas", "Andrew", "Joshua", "Nicholas", "Ryan", "Tyler"]

var ages = [13, 34, 45, 66, 21, 25, 66, 99, 101230, 3, 5, 3434]
var incomes = [2333, 21, 4544, 5666, 909, 4343, 95959, 20333]
var happinesses = [0.7, 0.3, 0.4, 0.99, 0.1, 0.12, 0.88, 0.24]

var elapsed_time = 0
const DURATION = 5 # duration between popups
var popup_open = false

var rooms = {}
var fPerson = Person_Obj.new("null", -1, -1, 0)

var room1coord = [340, 485, 220]
var room2coord = [340, 485, 350]
var room3coord = [340, 485, 478]
var room4coord = [655, 805, 220]
var room5coord = [655, 805, 350]
var room6coord = [655, 805, 478]

func spawnSprite(person: Person, room: String):
	
	
	
	var name_index = names.find(person.pName)
	


	var personSprite = $Node2D.get_child(names.find(person.pName))
	
	var room_number = int(room[-1])
	
	match room_number:
		1:
			personSprite.position.x = (room1coord[0] + room1coord[1]) / 2
			personSprite.position.y = room1coord[2]
		2:
			personSprite.position.x = (room2coord[0] + room2coord[1]) / 2
			personSprite.position.y = room2coord[2]
		3:
			personSprite.position.x = (room3coord[0] + room3coord[1]) / 2
			personSprite.position.y = room3coord[2]
		4:
			personSprite.position.x = (room4coord[0] + room4coord[1]) / 2
			personSprite.position.y = room4coord[2]
		5:
			personSprite.position.x = (room5coord[0] + room5coord[1]) / 2
			personSprite.position.y = room5coord[2]
		6:
			personSprite.position.x = (room6coord[0] + room6coord[1]) / 2
			personSprite.position.y = room6coord[2]
		_:
			print("Such room dont exist??")
			
	personSprite.scale = Vector2(2,2)

	personSprite.visible = true
	
	
	var tile = "tile" + str(names.find(person.pName))
	
	$Node2D/AnimationPlayer.play(tile)
	



var moveDirection := 1 # 1 for moving right, -1 for moving left
var moveAmount := 0.5


#these room coord arrays are in the format of [x_min, x_max, y]




func _process(delta):
	#if popup_open == false:
		#elapsed_time += delta
		#
	#if elapsed_time >= DURATION:
		#_on_show_pop_pressed()
		#print("timer called")
		#elapsed_time = 0
	
	#Assuming 6 rooms
	for room in rooms.keys():

		if(rooms[room] != fPerson):
			var personInRoom = rooms[room]

			
			var name_index = names.find(personInRoom.pName)
			
			
			var personSprite = $Node2D.get_child(name_index)
			
			
			
			var room_number = int(room[-1])
			var room_x_min: int
			var room_x_max: int
			match room_number:
				1:
					room_x_min = room1coord[0]
					room_x_max = room1coord[1]
				2:
					room_x_min = room2coord[0]
					room_x_max = room2coord[1]
				3:
					room_x_min = room3coord[0]
					room_x_max = room3coord[1]
				4:
					room_x_min = room4coord[0]
					room_x_max = room4coord[1]
				5:
					room_x_min = room5coord[0]
					room_x_max = room5coord[1]
				6:
					room_x_min = room6coord[0]
					room_x_max = room6coord[1]
				_:
					print("Such room dont exist??")
					
			personSprite.position.x += moveAmount * moveDirection
			
			if  room_x_min >= personSprite.position.x || room_x_max <= personSprite.position.x:
				moveDirection *= -1
				personSprite.scale.x *= -1
			
	

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

var happiness = 0
var money = 0

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
		var rName = "room_%d" % [i+1]
		rooms[rName] = fPerson
		
	var b2 = Person_Obj.new("Bartu", 21, 2000, 0.001)
	
	store_person_in_room(b2, "room_2")
	
	print("Person in room_2:")
	print(rooms["room_2"].pName)
	
	print("removing person...")
	remove_person_in_room("room_2")
	
	print("Person in room_2:")
	print(rooms["room_2"].pName)
	
	set_process(true)
	
var p1 :Person
var p2 :Person
func _on_show_pop_pressed():
	popup_open = true
	var control = $PopUpPeople
	var GenButton = $GenPerson
	var ShowButton = $ShowPop

	#var BuildingTilemaps = $building_tilemaps
	#BuildingTilemaps.visible = false

	
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



func _on_choose_2_pressed():
	print("s3w4edr5ftgyhuji")
	
	store_person_in_room(p2, "room_2")
	popup_open = false
	_on_exit_pressed()



func _on_room_1_pressed():
	var r1 = "room_1"
	var person = rooms[r1]
	
	print("Name: ", person.pName)
func update_averages():
	var total_happiness = 0.0
	var total_money = 0
	var num_persons = 0

	for room in rooms.values():
		if room != fPerson:  # Assuming fPerson is your 'empty' person
			total_happiness += room.happiness
			total_money += room.income
			num_persons += 1

	if num_persons > 0:
		happiness = total_happiness / num_persons
		money = total_money / num_persons
	else:
		happiness = 0
		money = 0

	# Optionally, update any UI elements or notify other parts of your game
	# For example:
	# $HappinessBar.value = happiness
	# $MoneyLabel.text = str(money)



	
	
	
	

func _on_choose_1_pressed():
	print("s3w4edr5ftgyhuji")
	store_person_in_room(p1, "room_2")
	popup_open = false
	_on_exit_pressed()
	




func _on_plsworkgod_pressed():
	var b2 = Person.new("Ava", 3, 2, 0.3)
	store_person_in_room(b2, "room_6")
	spawnSprite(b2, "room_6")
	print("HELLOOOOOOOOOOOOOOOO")
