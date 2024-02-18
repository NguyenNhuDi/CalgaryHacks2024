extends Node2D
var Person_Obj = preload("res://Person_Obj.gd")

var name_path = {"Bartu": "res://assets/Characters/tile000.png", "Di":"res://assets/Characters/tile001.png", "Brett":"res://assets/Characters/tile002.png", "Taylor":"res://assets/Characters/tile003.png", "Lucy":"res://assets/Characters/tile005.png", "Emma":"res://assets/Characters/tile007.png", "Liam":"res://assets/Characters/tile004.png", "Olivia":"res://assets/Characters/tile016.png", "Noah": "res://assets/Characters/tile006.png", "Ava": "res://assets/Characters/tile019.png", "William": "res://assets/Characters/tile008.png", "James": "res://assets/Characters/tile009.png", "Benjamin": "res://assets/Characters/tile010.png", "Elijah": "res://assets/Characters/tile011.png", "Andrew": "res://assets/Characters/tile013.png", "Joshua": "res://assets/Characters/tile014.png", "Nicholas": "res://assets/Characters/tile015.png", "Ryan": "res://assets/Characters/tile017.png", "Tyler": "res://assets/Characters/tile018.png"}
var profileName_path = {"Bartu": "res://assets/PortraitsFinal/Luimberjack.png", "Di":"res://assets/PortraitsFinal/old_man.png", "Brett":"res://assets/PortraitsFinal/Boy.png", "Taylor":"res://assets/PortraitsFinal/Girl.png", "Lucy":"res://assets/PortraitsFinal/Lady.png", "Emma":"res://assets/PortraitsFinal/Lady2.png", "Liam":"res://assets/PortraitsFinal/Glasses.png", "Olivia":"res://assets/PortraitsFinal/Girl2.png", "Noah": "res://assets/PortraitsFinal/old_man2.png", "Ava": "res://assets/PortraitsFinal/Kid2.png", "William": "res://assets/PortraitsFinal/Punk.png", "James": "res://assets/PortraitsFinal/Boy2.png", "Benjamin": "res://assets/PortraitsFinal/Goblin.png", "Elijah": "res://assets/PortraitsFinal/Knight.png", "Andrew": "res://assets/PortraitsFinal/Viking.png", "Joshua": "res://assets/PortraitsFinal/Wizard2.png", "Nicholas": "res://assets/PortraitsFinal/Detective.png", "Ryan": "res://assets/PortraitsFinal/Boy2.png", "Tyler": "res://assets/PortraitsFinal/Kid1.png"}
var names = ["Bartu", "Di", "Brett", "Taylor", "Lucy", "Emma", "Liam", "Olivia", "Noah", "Ava", "William", "James", "Benjamin", "Elijah", "Andrew", "Joshua", "Nicholas", "Ryan", "Tyler"]

var ages = [13, 34, 45, 66, 21, 25, 66, 99, 101230, 3, 5, 3434]
var incomes = [2333, 21, 4544, 5666, 909, 4343, 95959, 20333]
var happinesses = [0.7, 0.3, 0.4, 0.99, 0.1, 0.12, 0.88, 0.24]

var elapsed_time = 0
# TODO undo 100s wait time
const DURATION = 5 # duration between popups
var popup_open = false

func _process(delta):
	if popup_open == false: # start timer when the popup is not open
		elapsed_time += delta
		
	if elapsed_time >= DURATION: # open popup once timer reaches DURATION
		_on_show_pop_pressed()
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
	var lControl = $DisplayRoomLeft_Control
	var rControl = $DisplayRoomRight_Control
	lControl.visible = false
	rControl.visible = false
	
	
	# initialize rooms:
	for i in range(6):
		var rName = "room_%d" % [i+1]
		rooms[rName] = fPerson
		
	var b2 = Person_Obj.new("Bartu", 21, 1000, 0.85)
	rooms["room_1"] = b2
		
	
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
		money = money


	# Update happiness ProgressBar
	var hBar = $CanvasLayer/Happiness
	hBar.value = 100 * happiness

	# Update money ProgressBar
	var mBar = $CanvasLayer/Money
	# Convert average money to a percentage of 10000 for the ProgressBar
	var money_percentage = min(money / 1500.0, 100.0)  # Ensuring it doesn't exceed 100%
	mBar.value = money_percentage

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
		var path = name_path[p1.pName]
		#var path = preload(texture)
		var texture = load(path)

		# Create a Sprite2D node and set the texture
		var sprite = Sprite2D.new()
		sprite.texture = texture
#
		## Hard code the position for the sprite
		sprite.position = Vector2(100, 100)  # Adjust the position as needed
#
		## Add the sprite as a child of the current node (assuming this script is attached to a node)
		add_child(sprite)
		
		update_averages()  
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
		var path = name_path[p2.pName]
		var texture = load(path)

		# Create a Sprite2D node and set the texture
		var sprite = Sprite2D.new()
		sprite.texture = texture

		# Hard code the position for the sprite
		sprite.position = Vector2(100, 100)  # Adjust the position as needed

		# Add the sprite as a child of the current node (assuming this script is attached to a node)
		add_child(sprite)
		update_averages() 
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
	
	

var leftOn :bool = false
var leftPrevNum :int = -1

func displayLeftProfile(room_name):
	var control = $DisplayRoomLeft_Control
	var profile = $DisplayRoomLeft_Control/profile
	var stats = $DisplayRoomLeft_Control/stats
	var rNum = int(room_name[-1])
	

	# another profile is displayed
	if leftPrevNum != -1 and leftPrevNum != rNum:
		control.visible = false		
		profile.global_scale.x /= 2
		profile.global_scale.y /= 2
		leftPrevNum = -1
		leftOn = false		
	
	if not leftOn:
		control.visible = true
		
		var pName = rooms[room_name].pName
		var age = rooms[room_name].age
		var income = rooms[room_name].income
		var happiness = rooms[room_name].happiness
		
		stats.text = "Room: " + str(room_name[-1]) +  "\nName: " + pName + "\nAge: " + str(age) + "\nIncome: " + str(income) + "\nHappiness: " + str(happiness) + "\n"
		
		if pName != "null":
			profile.texture = load(profileName_path[pName])
		else:
			profile.texture = null
		profile.global_scale.x *= 2
		profile.global_scale.y *= 2
		
		leftPrevNum = rNum
		leftOn = true
	else:
		control.visible = false		
		profile.global_scale.x /= 2
		profile.global_scale.y /= 2
		leftPrevNum = -1
		leftOn = false		

var rightOn :bool = false
var rightPrevNum :int = -1

func displayRightProfile(room_name):
	var control = $DisplayRoomRight_Control
	var profile = $DisplayRoomRight_Control/profile
	var stats = $DisplayRoomRight_Control/stats
	var rNum = int(room_name[-1])
	
	# another profile is displayed
	if rightPrevNum != -1 and rightPrevNum != rNum:
		control.visible = false		
		profile.global_scale.x /= 2
		profile.global_scale.y /= 2
		rightPrevNum = -1
		rightOn = false		
	
	if not rightOn:
		control.visible = true
		
		var pName = rooms[room_name].pName
		var age = rooms[room_name].age
		var income = rooms[room_name].income
		var happiness = rooms[room_name].happiness
		
		stats.text = "Room: " + str(room_name[-1]) +  "\nName: " + pName + "\nAge: " + str(age) + "\nIncome: " + str(income) + "\nHappiness: " + str(happiness) + "\n"
		
		
		if pName != "null":
			profile.texture = load(profileName_path[pName])
		else:
			profile.texture = null		
		profile.global_scale.x *= 2
		profile.global_scale.y *= 2
		
		rightPrevNum = rNum
		rightOn = true
	else:
		control.visible = false		
		profile.global_scale.x /= 2
		profile.global_scale.y /= 2
		rightPrevNum = -1
		rightOn = false		
	

func _on_display_room_1_pressed():
	displayLeftProfile("room_1")
	
func _on_display_room_2_pressed():
	displayLeftProfile("room_2")

func _on_display_room_3_pressed():
	displayLeftProfile("room_3")

func _on_display_room_4_pressed():
	displayRightProfile("room_4")
	
func _on_display_room_5_pressed():
	displayRightProfile("room_5")

func _on_display_room_6_pressed():
	displayRightProfile("room_6")

func check_actions_and_switch_scene():
	if action_count > 3:
		get_tree().change_scene_to_file("res://new_day.tscn")


func _on_evict_left_pressed():
	var rNum = $DisplayRoomLeft_Control/stats.text[6]
	var rName = "room_%s" %[rNum]
	
	rooms[rName] = fPerson
	
	displayLeftProfile(rName)
	
