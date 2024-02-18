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
	check_actions_and_switch_scene()
		
		
	

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
var action_count = 0

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
	

var avg_happiness = GameState.get_happiness()
var avg_money = GameState.get_money()

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
		avg_happiness = total_happiness / num_persons
		GameState.update_happiness(avg_happiness)  # Update happiness in GameState

		avg_money = total_money
		GameState.update_money(avg_money)  # Update money in GameState

	# Retrieve updated values from GameState for use outside the if-else block
	var updated_happiness = GameState.get_happiness()
	var updated_money = GameState.get_money()

	# Calculate money as a percentage of 150,000
	var money_percentage = min((updated_money / 150000.0) * 100, 100)  # Ensure it doesn't exceed 100%

	# Update UI elements or other game parts with the new values
	$CanvasLayer/Happiness.value = updated_happiness * 100  # Convert to percentage if needed
	$CanvasLayer/Money.value = money_percentage  # Use calculated percentage


	print(avg_money)
	if happiness < 0.2 || money < 0: # temporary game over condition
		# game ova
		game_over()


func _on_choose_1_pressed():
	var unoccupied_rooms = get_unoccupied_rooms()
	if unoccupied_rooms.size() > 0:
		action_count+= 1
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
		action_count+= 1
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
	
var p1_on :bool = false
var p2_on :bool = false

func displayProfile(profile, pic, label, room_name, on):
	
	if not on:
		profile.visible = true
		
		var pName = rooms[room_name].pName
		var age = rooms[room_name].age
		var income = rooms[room_name].income
		var happiness = rooms[room_name].happiness
		
		label.text = "Name: " + pName + "\n" + "Age: " + str(age) + "\n" + "Income: " + str(income) + "\n" + "Happiness: " + str(happiness) + "\n"
		
		pic.texture = load("res://assets/PortraitsFinal/Boy2.png")
		pic.global_scale.x *= 2
		pic.global_scale.y *= 2
		
		on = true
	else:
		profile.visible = false		
		on = false
		pic.global_scale.x /= 2
		pic.global_scale.y /= 2
	
	return on
func game_over():
	print("game_over")
	get_tree().change_scene_to_file("res://game_over_scene.tscn")
	

func _on_display_room_1_pressed():
	var p = $DisplayRoom1_Control
	var pic = $DisplayRoom1_Control/p1Profile
	var label = $DisplayRoom1_Control/p1Info
	
	p1_on = displayProfile(p, pic, label, "room_1", p1_on)
	

func _on_display_room_2_pressed():
	var p = $DisplayRoom2_Control
	var pic = $DisplayRoom2_Control/p2Profile
	var label = $DisplayRoom2_Control/p2Info
	
	p2_on = displayProfile(p, pic, label, "room_2", p2_on)

# Assuming Godot 4.0
func check_actions_and_switch_scene():
	if action_count == 3:
		var timer = Timer.new()
		timer.wait_time = 4
		timer.one_shot = true
		add_child(timer)
		# Use Callable for connecting in Godot 4.0
		timer.connect("timeout", Callable(self, "_on_timer_timeout"))
		timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://new_day.tscn")
	# In Godot 4.0, you might not need to manually remove the Timer node if it's one_shot and auto-free on timeout is set

