variable "filename" {
    default = "/home/ubuntu/terraform_practise//file1.txt"
    type = string 
    description = "This variable is used to specify the filename for the local_file resource."
}

variable "content" {
    default = "This is local resource practise"
    type = string 
    description = "This variable is used to specify the content for the local_file resource."   
}

variable "prefix" {
    default = [ "Mrs", "Mr", "Ms" ]    
    type = list(string)
    description = "This variable is used to specify the prefix for the random_pet resource."
}

