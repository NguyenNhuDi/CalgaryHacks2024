extends Control

var Person_Obj = preload("res://Person_Obj.gd")

var names = ["Bartu", "Di", "Brett", "Taylor", "Lucy"]
var ages = [13, 34, 45, 66, 21, 25, 66, 99, 101230, 3, 5, 3434]
var incomes = [2333, 21, 4544, 5666, 909, 4343, 95959, 20333]
var happinesses = [0.7, 0.3, 0.4, 0.99, 0.1, 0.12, 0.88, 0.24]



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

## Function to show the pop-up window
#func show_popup():
	## Set the visibility of the Control node to true to show the pop-up
	#self.visible = true
	#
	#var two_people = createRandomPerson()
	#
		## Get a reference to the Label node
	#var Person1 = $Person1
#
	## Change the text displayed by the Label
	#Person1.text = two_people[0].pName
#
	#print("P1 attributes:")
	#print("Name: ", two_people[0].pName)
	#print("Age: ", two_people[0].age)
	#print("Income: ", two_people[0].income)
	#print("Happiness: ", two_people[0].happiness)
	#
	#print("\n\n\n")
	#
	#print("P2 attributes:")
	#print("Name: ", two_people[1].pName)
	#print("Age: ", two_people[1].age)
	#print("Income: ", two_people[1].income)
	#print("Happiness: ", two_people[1].happiness)
	#
	#print("\n\n\n")

# Function to hide the pop-up window
func hide_popup():
	# Set the visibility of the Control node to false to hide the pop-up
	self.visible = false

func _on_exit_pressed():
	hide_popup()


func _on_show_pop_pressed():
		# Set the visibility of the Control node to true to show the pop-up
	self.visible = true
	
	var two_people = createRandomPerson()
	
		# Get a reference to the Label node
	var Person1 = $Person1

	# Change the text displayed by the Label
	Person1.text = "P1 attributes:\n" + "Name: " + two_people[0].pName + "\nAge: " + str(two_people[0].age) + "\nIncome: " + str(two_people[0].income) + "\nHappiness: " + str(two_people[0].happiness)
		# Get a reference to the Label node
	var Person2 = $Person2

	# Change the text displayed by the Label
	Person2.text = "P2 attributes:\n" + "Name: " + two_people[1].pName + "\nAge: " + str(two_people[1].age) + "\nIncome: " + str(two_people[1].income) + "\nHappiness: " + str(two_people[1].happiness)

