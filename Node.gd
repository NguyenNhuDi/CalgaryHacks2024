extends Node
var Person_Obj = preload("res://Person_Obj.gd")

# Define global variables
var residents = {}
var happiness = 1.0
var money = 0
var action_count = 0
var rooms = {}
var fPerson = Person_Obj.new("null", -1, -1, 0)
var firstDay = true

func init_rooms():
	for i in range(6):
		rooms["room_"+str(i+1)] = fPerson
	return rooms

func get_rooms():
	return rooms

func get_fake_person():
	return fPerson

func store_rooms(person: Person, rName:String):
	rooms[rName] = person
	
# Function to update residents
func update_residents(new_residents):
	residents = new_residents

# Function to update happiness
func update_happiness(new_happiness):
	happiness = new_happiness

func get_happiness():
	return happiness

# Function to update money
func update_money(new_money):
	money = new_money
	
func get_money():
	return money

# Reset function if needed to reset the game state
func reset_game_state():
	residents.clear()
	happiness = 1.0
	money = 0
	action_count = 0

