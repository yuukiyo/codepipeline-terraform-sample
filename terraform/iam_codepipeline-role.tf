resource "aws_iam_role" "codepipeline-role" {
  name               = "codepipeline-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline-role-policy" {
  name = "codepipeline-role-policy"
  role = aws_iam_role.codepipeline-role.id

  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:GetObject*",
                "s3:GetBucket*",
                "s3:List*",
                "s3:DeleteObject*",
                "s3:PutObject*",
                "s3:Abort*"
            ],
            "Resource": [
                "${aws_s3_bucket.test.arn}",
                "${aws_s3_bucket.test.arn}/*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "kms:Decrypt",
                "kms:DescribeKey",
                "kms:Encrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*"
            ],
            "Resource": "${aws_kms_key.test.arn}",
            "Effect": "Allow"
        },
        {
            "Action": "sts:AssumeRole",
            "Resource": "${aws_iam_role.codepipeline-codecommit-role.arn}",
            "Effect": "Allow"
        },
        {
            "Action": "sts:AssumeRole",
            "Resource": "${aws_iam_role.codepipeline-codebuild-role.arn}",
            "Effect": "Allow"
        }
    ]
}
  EOF
}
