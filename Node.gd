extends Node

# Define global variables
var residents = {}
var happiness = 1.0
var money = 0
var action_count = 0

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
	
# Function to update action count
func update_action_count(new_count):
	action_count = new_count

# Reset function if needed to reset the game state
func reset_game_state():
	residents.clear()
	happiness = 1.0
	money = 0
	action_count = 0

