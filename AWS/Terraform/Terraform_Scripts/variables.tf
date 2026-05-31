resource "aws_variable" "my-ip" {
    description = "My IP address in CIDR notation"
    type        = string
    default     = "192.168.32.10/32"
}