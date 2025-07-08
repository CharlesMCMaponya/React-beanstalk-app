output "beanstalk_env_name" {
  value = aws_elastic_beanstalk_environment.react_env.name
}

output "application_name" {
  value = aws_elastic_beanstalk_application.react_app.name
}
