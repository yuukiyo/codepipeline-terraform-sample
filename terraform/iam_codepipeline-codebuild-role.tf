resource "aws_iam_role" "codepipeline-codebuild-role" {
  name               = "codepipeline-codebuild-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline-codebuild-role-policy" {
  name = "codepipeline-codebuild-role-policy"
  role = aws_iam_role.codepipeline-codebuild-role.id

  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "codebuild:BatchGetBuilds",
                "codebuild:StartBuild",
                "codebuild:StopBuild"
            ],
            "Resource": "${aws_codebuild_project.test.arn}",
            "Effect": "Allow"
        }
    ]
}
  EOF
}
