resource "aws_iam_role" "cloudwatch-event-rule-role" {
  name               = "cloudwatch-event-rule-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "cloudwatch-event-rule-role-policy" {
  name = "cloudwatch-event-rule-role-policy"
  role = aws_iam_role.cloudwatch-event-rule-role.id

  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "codepipeline:StartPipelineExecution",
            "Resource": "${aws_codepipeline.test.arn}",
            "Effect": "Allow"
        }
    ]
}
  EOF
}
