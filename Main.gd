extends Node2D
var Person_Obj = preload("res://Person_Obj.gd")

var names = ["Bartu", "Di", "Brett", "Taylor", "Lucy"]
var ages = [13, 34, 45, 66, 21, 25, 66, 99, 101230, 3, 5, 3434]
var incomes = [2333, 21, 4544, 5666, 909, 4343, 95959, 20333]
var happinesses = [0.7, 0.3, 0.4, 0.99, 0.1, 0.12, 0.88, 0.24]

var elapsed_time = 0
const DURATION = 5 # duration between popups
var popup_open = false

func _process(delta):
	if popup_open == false: # start timer when the popup is not open
		elapsed_time += delta
		
	if elapsed_time >= DURATION: # open popup once timer reaches DURATION
		_on_show_pop_pressed()
		print("timer called")
		elapsed_time = 0
	update_averages()
		
		
	

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

var happiness = 1
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
	popup_open = true
	var control = $PopUpPeople

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
	control.visible = false


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
		happiness = happiness
		money = 0

	# Update happiness ProgressBar
	var hBar = $CanvasLayer/Happiness
	hBar.value = 100 * happiness

	# Update money ProgressBar
	var mBar = $CanvasLayer/Money
	# Convert average money to a percentage of 10000 for the ProgressBar
	var money_percentage = min(money / 1500.0, 100.0)  # Ensuring it doesn't exceed 100%
	mBar.value = money_percentage

	print("Happiness: ", happiness)
	print("Money Percentage: ", money_percentage)


	# Optionally, update any UI elements or notify other parts of your game
	# For example:
	# $HappinessBar.value = happiness
	# $MoneyLabel.text = str(money)
	
	if happiness < 0.2 || money < 0: # temporary game over condition
		# game ova
		game_over()


func _on_choose_1_pressed():
	var unoccupied_rooms = get_unoccupied_rooms()
	if unoccupied_rooms.size() > 0:
		var random_room = unoccupied_rooms[randi() % unoccupied_rooms.size()]
		store_person_in_room(p1, random_room)
		popup_open = false
		update_averages()  # Recalculate averages if necessary
		_on_exit_pressed()
	else:
		print("No unoccupied rooms available.")
		
func _on_choose_2_pressed():
	var unoccupied_rooms = get_unoccupied_rooms()
	if unoccupied_rooms.size() > 0:
		var random_room = unoccupied_rooms[randi() % unoccupied_rooms.size()]
		store_person_in_room(p2, random_room)
		popup_open = false
		update_averages()  # Recalculate averages if necessary
		_on_exit_pressed()
	else:
		print("No unoccupied rooms available.")	

func get_unoccupied_rooms():
	var unoccupied = []
	for room_name in rooms.keys():
		if rooms[room_name] == fPerson:
			unoccupied.append(room_name)
	return unoccupied
	
func game_over():
	print("game_over")
	get_tree().change_scene_to_file("res://game_over_scene.tscn")
	
	

