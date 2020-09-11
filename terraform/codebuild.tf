resource "aws_codebuild_project" "test" {
  name         = "codebuild-project"
  service_role = aws_iam_role.codebuild-project-role.arn
  artifacts {
    packaging = "NONE"
    type      = "CODEPIPELINE"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "Env"
      type  = "PLAINTEXT"
      value = "Prod"
    }
  }
  source {
    type            = "CODEPIPELINE"
    git_clone_depth = 0
    buildspec       = <<EOF
{
  "phases": {
    "build": {
      "commands": [
        "ls -al"
      ]
    },
  },
  "version": "0.2"
}
EOF
  }
}
