resource "aws_codepipeline" "test" {
  name     = "cross-account-test-pipeline"
  role_arn = aws_iam_role.codepipeline-role.arn
  artifact_store {
    encryption_key {
      id   = aws_kms_key.test.arn
      type = "KMS"
    }
    location = aws_s3_bucket.test.id
    type     = "S3"
  }
  stage {
    name = "Source"
    action {
      provider = "CodeCommit"
      category = "Source"
      configuration = {
        BranchName           = "master"
        PollForSourceChanges = "false"
        RepositoryName       = aws_codecommit_repository.test.id
      }
      name             = "hoge"
      owner            = "AWS"
      version          = "1"
      output_artifacts = ["codecommit-artifact-name"]
      role_arn         = aws_iam_role.codepipeline-codecommit-role.arn
    }
  }
  stage {
    name = "Build"
    action {
      category = "Build"
      configuration = {
        ProjectName = aws_codebuild_project.test.name
      }
      input_artifacts = ["codecommit-artifact-name"]
      name            = aws_codebuild_project.test.name
      provider        = "CodeBuild"
      owner           = "AWS"
      version         = "1"
      role_arn        = aws_iam_role.codepipeline-codebuild-role.arn
      output_artifacts = [
        "Artifact_Build_CodeBuild"
      ]
    }
  }
}
