resource "aws_cloudwatch_log_group" "cwl_log_group" {
  name = "${var.cloudwatch_log_group_name}"

  //  tags = '${merge(var.common_tags, map("Name", "${var.cloudwatch_log_group_name"))}'
}
