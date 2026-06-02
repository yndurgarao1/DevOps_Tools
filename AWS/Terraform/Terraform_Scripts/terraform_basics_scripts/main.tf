resource "local_file" "my-file" {
    filename = var.filename
    content = "This is local resource practise"
}

resource "random_pet" "my-pet" {
    prefix = "Mrs"
    separator = "."
    length = 1
}

output "filename " {
    value = local_file.my-file.filename
}
output "pet_name " {
    value = random_pet.my-pet.id
}
