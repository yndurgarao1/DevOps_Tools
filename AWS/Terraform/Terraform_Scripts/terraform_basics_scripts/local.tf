resource "local_file" "my-file" {
    filename = "/home/ubuntu/terraform_practise//file1.txt"
    content = "This is local resource practise"
}
