extends Control

var Person_Obj = preload("res://Person_Obj.gd")

var names = ["Bartu", "Di", "Brett", "Taylor", "Lucy"]
var ages = [13, 34, 45, 66, 21, 25, 66, 99, 101230, 3, 5, 3434]
var incomes = [2333, 21, 4544, 5666, 909, 4343, 95959, 20333]
var happinesses = [0.7, 0.3, 0.4, 0.99, 0.1, 0.12, 0.88, 0.24]

	
var rooms = {}
var fPerson = Person_Obj.new("null", -1, -1, 0)

# Function to create random people
func createRandomPerson():
	var names_copy = names.duplicate()
	var ages_copy = ages.duplicate()
	var incomes_copy = incomes.duplicate()
	var happinesses_copy = happinesses.duplicate()
	
	var rand_name1 = names_copy.pop_at(randi_range(0, names_copy.size() - 1))
	var rand_age1 = ages_copy.pop_at(randi_range(0, ages_copy.size() - 1))
	var rand_income1 = incomes_copy.pop_at(randi_range(0, incomes_copy.size() - 1))
	var rand_happiness1 = happinesses_copy.pop_at(randi_range(0, happinesses_copy.size() - 1))
	
	var rand_name2 = names_copy.pop_at(randi_range(0, names_copy.size() - 1))
	var rand_age2 = ages_copy.pop_at(randi_range(0, ages_copy.size() - 1))
	var rand_income2 = incomes_copy.pop_at(randi_range(0, incomes_copy.size() - 1))
	var rand_happiness2 = happinesses_copy.pop_at(randi_range(0, happinesses_copy.size() - 1))
	
	var p1 = Person_Obj.new(rand_name1, rand_age1, rand_income1, rand_happiness1)  
	var p2 = Person_Obj.new(rand_name2, rand_age2, rand_income2, rand_happiness2)  

	return [p1, p2]

func _ready():
	# Hide the pop-up by default
	self.visible = false

# Called when the "Exit" button is pressed
func _on_exit_pressed():
	self.visible = false

# Called when the "Show Pop-up" button is pressed
func _on_show_pop_pressed():
	self.visible = true
	
	var two_people = createRandomPerson()
	
	var Person1 = $Person1
	Person1.text = "P1 attributes:\n" + "Name: " + two_people[0].pName + "\nAge: " + str(two_people[0].age) + "\nIncome: " + str(two_people[0].income) + "\nHappiness: " + str(two_people[0].happiness)
	
	var Person2 = $Person2
	Person2.text = "P2 attributes:\n" + "Name: " + two_people[1].pName + "\nAge: " + str(two_people[1].age) + "\nIncome: " + str(two_people[1].income) + "\nHappiness: " + str(two_people[1].happiness)

# Called when the "Play" button is pressed
func _on_play_pressed():
	var game_scene_path = "res://Main.tscn"
	get_tree().change_scene_to_file(game_scene_path)

# Called when the "Quit" button is pressed
func _on_quit_pressed():
	get_tree().quit()
	
	

func _on_choose_1_pressed(room:String):
	assert(room in rooms, "%s not in rooms" % [room])
	rooms[room] = fPerson

