resource "random_pet" "my-pet" {
	prefix = "Mrs"
	separator = "."
	length = 1
}

output "pet_name " {
	value = random_pet.my-pet.id
}