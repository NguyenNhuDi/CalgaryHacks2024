extends Node2D
var Person_Obj = preload("res://Person_Obj.gd")


var name_path = {"Bartu": "res://assets/Characters/tile000.png", "Di":"res://assets/Characters/tile001.png", "Brett":"res://assets/Characters/tile002.png", "Taylor":"res://assets/Characters/tile003.png", "Lucy":"res://assets/Characters/tile005.png", "Emma":"res://assets/Characters/tile007.png", "Liam":"res://assets/Characters/tile004.png", "Olivia":"res://assets/Characters/tile016.png", "Noah": "res://assets/Characters/tile006.png", "Ava": "res://assets/Characters/tile019.png", "William": "res://assets/Characters/tile008.png", "James": "res://assets/Characters/tile009.png", "Benjamin": "res://assets/Characters/tile010.png", "Elijah": "res://assets/Characters/tile011.png", "Andrew": "res://assets/Characters/tile013.png", "Joshua": "res://assets/Characters/tile014.png", "Nicholas": "res://assets/Characters/tile015.png", "Ryan": "res://assets/Characters/tile017.png", "Tyler": "res://assets/Characters/tile018.png"}
var profileName_path = {"Bartu": "res://assets/PortraitsFinal/Luimberjack.png", "Di":"res://assets/PortraitsFinal/old_man.png", "Brett":"res://assets/PortraitsFinal/Boy.png", "Taylor":"res://assets/PortraitsFinal/Girl.png", "Lucy":"res://assets/PortraitsFinal/Glasses.png", "Emma":"res://assets/PortraitsFinal/Lady.png", "Liam":"res://assets/PortraitsFinal/old_man2.png", "Olivia":"res://assets/PortraitsFinal/Lady2.png", "Noah": "res://assets/PortraitsFinal/Punk.png", "Ava": "res://assets/PortraitsFinal/FarmerBoy.png", "William": "res://assets/PortraitsFinal/Goblin.png", "James": "res://assets/PortraitsFinal/Knight.png", "Benjamin": "res://assets/PortraitsFinal/Viking.png", "Elijah": "res://assets/PortraitsFinal/Wizard2.png", "Andrew": "res://assets/PortraitsFinal/Detective.png", "Joshua": "res://assets/PortraitsFinal/Girl2.png", "Nicholas": "res://assets/PortraitsFinal/Boy2.png", "Ryan": "res://assets/PortraitsFinal/Kid1.png", "Tyler": "res://assets/PortraitsFinal/Kid2.png"}
var names = ["Bartu", "Di", "Brett", "Taylor", "Joshua", "Emma", "Liam", "Olivia", "Noah", "Ava", "William", "James", "Benjamin", "Elijah", "Andrew", "Lucy", "Nicholas", "Ryan", "Tyler"]

var ages = [13, 34, 45, 66, 21, 25, 66, 99, 101230, 3, 5, 3434]
var incomes = [2333, 21, 4544, 5666, 909, 4343, 959, 333]
var happinesses = [0.7, 0.3, 0.4, 0.99, 0.1, 0.12, 0.88, 0.24]

var elapsed_time = 0
# TODO undo 100s wait time
const DURATION = 1 # duration between popups
var popup_open = false

var daily_quota = 1000 # can change, plus is updated dynamically in check_actions...????

var rooms = {}
var fPerson = Person_Obj.new("null", -1, -1, 0)

var room1coord = [340, 485, 220]
var room2coord = [340, 485, 350]
var room3coord = [340, 485, 478]
var room4coord = [655, 805, 220]
var room5coord = [655, 805, 350]
var room6coord = [655, 805, 478]

var moveDirection := 1 # 1 for moving right, -1 for moving left
var moveAmount := 0.5

func _process(delta):
	if popup_open == false: # start timer when the popup is not open
		elapsed_time += delta
		
	if elapsed_time >= DURATION: # open popup once timer reaches DURATION
		_on_show_pop_pressed()
		elapsed_time = 0
		
	update_averages()
	check_actions_and_switch_scene()
	
	
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

var action_count = 0

	



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
		
	
	set_process(true)
	
var p1 :Person
var p2 :Person
var whichRoom :String
func _on_show_pop_pressed():
	popup_open = true
	var control = $PopUpPeople

	control.visible = true
	
	var two_people = createRandomPerson()
	
	var unoccupied_rooms = get_unoccupied_rooms()
	var rRoom = "null"
	if unoccupied_rooms.size() > 0:
		rRoom = unoccupied_rooms[randi() % unoccupied_rooms.size()]
		
	if rRoom == "null":
		print("No unoccupied rooms available.")
		control.visble = false
		
	whichRoom = rRoom
	
	var Person1 = $PopUpPeople/Person1

	Person1.text = "P1 attributes:\n" + "Name: " + two_people[0].pName + "\nAge: " + str(two_people[0].age) + "\nIncome: " + str(two_people[0].income) + "\nHappiness: " + str(two_people[0].happiness) + "\nRoom: " + str(rRoom[-1])

	
	var Person2 = $PopUpPeople/Person2
	Person2.text = "P2 attributes:\n" + "Name: " + two_people[1].pName + "\nAge: " + str(two_people[1].age) + "\nIncome: " + str(two_people[1].income) + "\nHappiness: " + str(two_people[1].happiness) + "\nRoom: " + str(rRoom[-1])
	

	
	p1 = two_people[0]
	p2 = two_people[1]
	
	

func _on_exit_pressed():
	var control = $PopUpPeople
	control.visible = false
	
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

	# Optionally, update any UI elements or notify other parts of your game
	# For example:
	# $HappinessBar.value = happiness
	# $MoneyLabel.text = str(money)
	if check_game_over_state():
		game_over()
	
	
	
func check_game_over_state(): # returns treu if game over
	print(GameState.get_money())
	if GameState.get_happiness() < 0.2: # temporary game over condition
		# game ova
		low_happiness()
	
	if GameState.get_money() < 0:
		return true
		
	return false


	
	
	
	

func _on_choose_1_pressed():

	action_count+= 1
	store_person_in_room(p1, whichRoom)
	spawnSprite(p1, whichRoom)
	popup_open = false
	
	update_averages()  
	var control = $PopUpPeople # exit
	control.visible = false


		
func _on_choose_2_pressed():
	action_count+= 1
	store_person_in_room(p2, whichRoom)
	spawnSprite(p2, whichRoom)
	popup_open = false
	
	update_averages() 
	var control = $PopUpPeople # exit
	control.visible = false


func get_unoccupied_rooms():
	var unoccupied = []
	for room_name in rooms.keys():
		if rooms[room_name] == fPerson:
			unoccupied.append(room_name)
	return unoccupied
	

func game_over():
	print("game_over")
	get_tree().change_scene_to_file("res://game_over_scene.tscn")
	
func low_happiness():
	# temporary, for future implemet more complex thingy / kick someone out idk
	#game_over()
	pass
	

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


func _on_evict_left_pressed():
	var rNum = $DisplayRoomLeft_Control/stats.text[6]
	var rName = "room_%s" %[rNum]
	
	var personName = rooms[rName].pName
	
	rooms[rName] = fPerson
	var name_index = names.find(personName)
	var personSprite = $Node2D.get_child(name_index)
	personSprite.visible = false
	displayLeftProfile(rName)
	
func _on_evict_right_pressed():
	var rNum = $DisplayRoomRight_Control/stats.text[6]
	var rName = "room_%s" %[rNum]
	
	var personName = rooms[rName].pName
	
	rooms[rName] = fPerson
	var name_index = names.find(personName)
	var personSprite = $Node2D.get_child(name_index)
	personSprite.visible = false
	displayRightProfile(rName)


func check_actions_and_switch_scene():
	if action_count == 3:
		# subtract the quota from profit then update the quota 
		avg_money -= daily_quota
		GameState.update_money(avg_money)

		
		if !check_game_over_state():
			var timer = Timer.new()
			timer.wait_time = 2
			timer.one_shot = true
			add_child(timer)
			# Use Callable for connecting in Godot 4.0
			timer.connect("timeout", Callable(self, "_on_timer_timeout"))
			timer.start()
		else:
			game_over()
			GameState.reset_game_state()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://new_day.tscn")
	# In Godot 4.0, you might not need to manually remove the Timer node if it's one_shot and auto-free on timeout is set




