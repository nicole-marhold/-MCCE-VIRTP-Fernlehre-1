output "webserver-url" {
  value = "http://${aws_instance.webserver.public_ip}:80"
}
