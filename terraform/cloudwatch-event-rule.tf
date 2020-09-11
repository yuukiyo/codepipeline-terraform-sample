resource "aws_cloudwatch_event_rule" "test" {
  name          = "test"
  event_pattern = <<EOF
{
  "detail-type": [
    "CodeCommit Repository State Change"
  ],
  "resources": [
    "${aws_codecommit_repository.test.arn}"
  ],
  "source": [
    "aws.codecommit"
  ],
  "detail": {
    "event": [
      "referenceCreated",
      "referenceUpdated"
    ],
    "referenceName": [
      "master"
    ]
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "test2" {
  rule     = aws_cloudwatch_event_rule.test.id
  arn      = aws_codepipeline.test.arn
  role_arn = aws_iam_role.cloudwatch-event-rule-role.arn
}
