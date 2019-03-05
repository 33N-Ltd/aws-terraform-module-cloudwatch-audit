resource "aws_sns_topic" "sns_topic" {
  name = "${var.sns_topic_name}"
  display_name = "${var.sns_display_name}"
}