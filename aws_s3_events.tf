resource "aws_cloudwatch_event_rule" "s3_policy_change_rule" {
  name = "${var.s3_policy_change_rule_name}"
  description = "Captures changes to S3 buckets"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.s3"
  ],
  "detail-type": [
    "AWS API calls via Cloudtrail"
  ],
  "detail": {
    "eventSource": [
      "s3.amazonaws.com"
    ],
    "eventName": [
      "DeleteBucket",
      "CreateBucket",
      "DeleteBucketCors",
      "DeleteBucketLifecycle",
      "DeleteBucketPolicy",
      "DeleteBucketReplication",
      "DeleteBucketTagging",
      "DeleteBucketWebsite",
      "PutBucketAcl",
      "PutBucketCors",
      "PutBucketLifecycle",
      "PutBucketLogging",
      "PutBucketNotification",
      "PutBucketPolicy",
      "PutBucketReplication",
      "PutBucketRequestPayment",
      "PutBucketTagging",
      "PutBucketVersioning",
      "PutBucketWebsite"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "sns" {
  arn = "${aws_sns_topic.sns_topic.arn}"
  rule = "${aws_cloudwatch_event_rule.s3_policy_change_rule.name}"
  target_id = "SendToSNS"
}