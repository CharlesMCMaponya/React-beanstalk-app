provider "aws" {
  region = "us-east-1"
}

resource "aws_elastic_beanstalk_application" "react_app" {
  name        = "react-beanstalk-app"
  description = "React app hosted on AWS Elastic Beanstalk"
}

# Create an IAM role for Elastic Beanstalk
resource "aws_iam_role" "eb_ec2_role" {
  name = "aws-elasticbeanstalk-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eb_ec2_role_policy" {
  role       = aws_iam_role.eb_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_instance_profile" "eb_ec2_profile" {
  name = "aws-elasticbeanstalk-ec2-role"
  role = aws_iam_role.eb_ec2_role.name
}

# Create service role for Elastic Beanstalk
resource "aws_iam_role" "eb_service_role" {
  name = "aws-elasticbeanstalk-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "elasticbeanstalk.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eb_service_role_policy" {
  role       = aws_iam_role.eb_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
}

resource "aws_elastic_beanstalk_environment" "react_env" {
  name                = "react-env"
  application         = aws_elastic_beanstalk_application.react_app.name
  solution_stack_name = "64bit Amazon Linux 2023 v6.6.0 running Node.js 20"

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "NODE_ENV"
    value     = "production"
  }

  # IAM settings
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.eb_ec2_profile.name
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = aws_iam_role.eb_service_role.arn
  }

  # Deployment settings
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "AllAtOnce"
  }

  # Health check settings
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "basic"
  }

  # Timeout settings
  depends_on = [
    aws_iam_role_policy_attachment.eb_ec2_role_policy,
    aws_iam_role_policy_attachment.eb_service_role_policy
  ]
}