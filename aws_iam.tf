resource "aws_iam_policy" "cwl_logs" {
  name        = "${var.cloudwatch_log_group_name}-policy"
  description = "Policy for adding cloudwatch logs"

  policy = <<EOF
{
      "Statement":[
        {
          "Effect":"Allow",
          "Action":[
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource":[
            "${aws_cloudwatch_log_group.cwl_log_group.arn}"
          ]
        }
}
EOF
}

resource "aws_iam_role" "cwl_logs" {
  name = "${var.cloudwatch_log_group_name}-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
}
EOF
}

resource "aws_iam_role_policy_attachment" "cwl_log_role_attachement" {
  depends_on = ["aws_iam_policy.cwl_logs"]
  role       = "${aws_iam_role.cwl_logs.name}"
  policy_arn = "${aws_iam_policy.cwl_logs.arn}"
}
