### 手順
1. CodePipelineなど一連の流れを作成するためにterraform apply
1. [CodeCommit]CPアカウントからクロスアカウントアクセスできるように作成（権限はCC、KMS、S3）
2. [CodePipeline]CPのAssumeRole権限追加
3. [CodePipeline]CPのRoleをCCロールに変更
4. [CodePipeline]CPのS3バケットをCCアカウントからアクセスできるように変更する(2箇所)
5. [CodePipeline]CPのKMSキーをCCアカウントからアクセスできるように変更する
6. [CodeCommit]CloudWatchEvent作成
7. [CodePipeline]CloudWatchイベントのcodecommitのARNを変える

