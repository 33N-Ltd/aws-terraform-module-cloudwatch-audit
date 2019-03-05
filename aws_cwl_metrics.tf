resource "aws_cloudwatch_log_metric_filter" "SecurityGroupChangesMetricFilter" {
  log_group_name = "${var.cloudwatch_log_group_name}"
  "metric_transformation" {
    name = "SecurityGroupEventCount"
    namespace = "CloudTrailMetrics"
    value = "1"
  }
  name = "SecurityGroupEventCount"
  pattern = "{ ($.eventName = AuthorizeSecurityGroupIngress) || ($.eventName = AuthorizeSecurityGroupEgress) || ($.eventName = RevokeSecurityGroupIngress) || ($.eventName = RevokeSecurityGroupEgress) || ($.eventName = CreateSecurityGroup) || ($.eventName = DeleteSecurityGroup) }"
}

resource "aws_cloudwatch_metric_alarm" "SecurityGroupChangesAlarm" {
  alarm_name = "CloudTrailSecurityGroupChanges"
  alarm_description = "Alarms when an API call is made to create, update or delete a Security Group"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "${aws_cloudwatch_log_metric_filter.SecurityGroupChangesMetricFilter.name}"
  namespace = "CloudTrailMetrics"
  period = 300
  threshold = 1
  statistic = "Sum"
  alarm_actions = ["${aws_sns_topic.sns_topic.arn}"]
}

resource "aws_cloudwatch_log_metric_filter" "NetworkAclChangesMetricFilter" {
  log_group_name = "${var.cloudwatch_log_group_name}"
  "metric_transformation" {
    name = "NetworkAclEventCount"
    namespace = "CloudTrailMetrics"
    value = "1"
  }
  name = "NetworkAclEventCount"
  pattern = "{ ($.eventName = CreateNetworkAcl) || ($.eventName = CreateNetworkAclEntry) || ($.eventName = DeleteNetworkAcl) || ($.eventName = DeleteNetworkAclEntry) || ($.eventName = ReplaceNetworkAclEntry) || ($.eventName = ReplaceNetworkAclAssociation) }"
}

resource "aws_cloudwatch_metric_alarm" "NetworkAclChangesAlarm" {
  alarm_name = "CloudTrailNetworkAclChanges"
  alarm_description = "Alarm when an API call is made to create, change or delete a Network ACL"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "${aws_cloudwatch_log_metric_filter.NetworkAclChangesMetricFilter.name}"
  namespace = "CloudTrailMetrics"
  period = 300
  threshold = 1
  statistic = "Sum"
  alarm_actions = ["${aws_sns_topic.sns_topic.arn}"]
}

resource "aws_cloudwatch_log_metric_filter" "GatewayChangesMetricFilter" {
  log_group_name = "${var.cloudwatch_log_group_name}"
  "metric_transformation" {
    name = "GatewayEventCount"
    namespace = "CloudTrailMetrics"
    value = "1"
  }
  name = "GatewayEventCount"
  pattern = "{ ($.eventName = CreateCustomerGateway) || ($.eventName = DeleteCustomerGateway) || ($.eventName = AttachInternetGateway) || ($.eventName = CreateInternetGateway) || ($.eventName = DeleteInternetGateway) || ($.eventName = DetachInternetGateway) }"
}

resource "aws_cloudwatch_metric_alarm" "GatewayChangesAlarm" {
  alarm_name = "CloudTrailGatewayChanges"
  alarm_description = "Alarm when an API call is made to create, change or delete a Customer or Internet Gateway"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "${aws_cloudwatch_log_metric_filter.GatewayChangesMetricFilter.name}"
  namespace = "CloudTrailMetrics"
  period = 300
  threshold = 1
  statistic = "Sum"
  alarm_actions = ["${aws_sns_topic.sns_topic.arn}"]
}

resource "aws_cloudwatch_log_metric_filter" "VpcChangesMetricFilter" {
  log_group_name = "${var.cloudwatch_log_group_name}"
  "metric_transformation" {
    name = "VpcEventCount"
    namespace = "CloudTrailMetrics"
    value = "1"
  }
  name = "VpcEventCount"
  pattern = "{ ($.eventName = CreateVpc) || ($.eventName = DeleteVpc) || ($.eventName = ModifyVpcAttribute) || ($.eventName = AttachVpcPeeringConnection) || ($.eventName = CreateVpcPeeringConnection) || ($.eventName = DeleteVpcPeeringConnection) || ($.eventName = RejectVpcPeeringConnection)}"
}

resource "aws_cloudwatch_metric_alarm" "VpcChangesAlarm" {
  alarm_name = "CloudTrailVpcChanges"
  alarm_description = "Alarm when an API call is made to create, change or delete a VPC"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "${aws_cloudwatch_log_metric_filter.VpcChangesMetricFilter.name}"
  namespace = "CloudTrailMetrics"
  period = 300
  threshold = 1
  statistic = "Sum"
  alarm_actions = ["${aws_sns_topic.sns_topic.arn}"]
}

resource "aws_cloudwatch_log_metric_filter" "EC2InstanceChangesMetricFilter" {
  log_group_name = "${var.cloudwatch_log_group_name}"
  "metric_transformation" {
    name = "EC2InstanceEventCount"
    namespace = "CloudTrailMetrics"
    value = "1"
  }
  name = "EC2InstanceEventCount"
  pattern = "{ ($.eventName = RunInstances) || ($.eventName = RebootInstances) || ($.eventName = StartInstances) || ($.eventName = StopInstances) || ($.eventName = TerminateInstances)}"
}

resource "aws_cloudwatch_metric_alarm" "EC2InstanceChangesAlarm" {
  alarm_name = "CloudTrailEC2InstanceChanges"
  alarm_description = "Alarm when an API call is made to create, change or delete an EC2 instance"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "${aws_cloudwatch_log_metric_filter.EC2InstanceChangesMetricFilter.name}"
  namespace = "CloudTrailMetrics"
  period = 300
  threshold = 1
  statistic = "Sum"
  alarm_actions = ["${aws_sns_topic.sns_topic.arn}"]
}

resource "aws_cloudwatch_log_metric_filter" "EC2LargeInstanceChangesMetricFilter" {
  log_group_name = "${var.cloudwatch_log_group_name}"
  "metric_transformation" {
    name = "EC2LargeInstanceEventCount"
    namespace = "CloudTrailMetrics"
    value = "1"
  }
  name = "EC2LargeInstanceEventCount"
  pattern = "{ ($.eventName = RunInstances) && ($.requestParameters.instanceType = *.8xlarge) || ($.requestParameters.instanceType = *.4xlarge)}"
}

resource "aws_cloudwatch_metric_alarm" "EC2LargeInstanceChangesAlarm" {
  alarm_name = "CloudTrailEC2LargeInstanceChanges"
  alarm_description = "Alarm when an API call is made to create, change or delete an EC2 x4 or x8 large instance"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "${aws_cloudwatch_log_metric_filter.EC2LargeInstanceChangesMetricFilter.name}"
  namespace = "CloudTrailMetrics"
  period = 300
  threshold = 1
  statistic = "Sum"
  alarm_actions = ["${aws_sns_topic.sns_topic.arn}"]
}

resource "aws_cloudwatch_log_metric_filter" "CloudTrailChangesMetricFilter" {
  log_group_name = "${var.cloudwatch_log_group_name}"
  "metric_transformation" {
    name = "CloudTrailEventCount"
    namespace = "CloudTrailMetrics"
    value = "1"
  }
  name = "CloudTrailEventCount"
  pattern = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging)}"
}

resource "aws_cloudwatch_metric_alarm" "CloudTrailChangesAlarm" {
  alarm_name = "CloudTrailChanges"
  alarm_description = "Alarm when an API call is made to create, start, update or stop CloudTrail logging"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "${aws_cloudwatch_log_metric_filter.CloudTrailChangesMetricFilter.name}"
  namespace = "CloudTrailMetrics"
  period = 300
  threshold = 1
  statistic = "Sum"
  alarm_actions = ["${aws_sns_topic.sns_topic.arn}"]
}

resource "aws_cloudwatch_log_metric_filter" "ConsoleSignInFailuresChangesMetricFilter" {
  log_group_name = "${var.cloudwatch_log_group_name}"
  "metric_transformation" {
    name = "ConsoleFailEventCount"
    namespace = "CloudTrailMetrics"
    value = "1"
  }
  name = "ConsoleFailEventCount"
  pattern = "{ ($.eventName = ConsoleLogin) && ($.errorMessage = \"Failed authentication\") }"
}

resource "aws_cloudwatch_metric_alarm" "ConsoleSignInFailuresAlarm" {
  alarm_name = "CloudTrailConsoleSignInFailures"
  alarm_description = "Alarm when an unathenticated API call is made to sign into the Console"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "${aws_cloudwatch_log_metric_filter.ConsoleSignInFailuresChangesMetricFilter.name}"
  namespace = "CloudTrailMetrics"
  period = 300
  threshold = 3
  statistic = "Sum"
  alarm_actions = ["${aws_sns_topic.sns_topic.arn}"]
}

resource "aws_cloudwatch_log_metric_filter" "AuthorizationFailuresChangesMetricFilter" {
  log_group_name = "${var.cloudwatch_log_group_name}"
  "metric_transformation" {
    name = "AuthFailEventCount"
    namespace = "CloudTrailMetrics"
    value = "1"
  }
  name = "AuthFailEventCount"
  pattern = "{ ($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\") }"
}

resource "aws_cloudwatch_metric_alarm" "AuthorizationFailuresAlarm" {
  alarm_name = "CloudTrailAuthorizationFailures"
  alarm_description = "Alarms when an unauthrized API call is made"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "${aws_cloudwatch_log_metric_filter.AuthorizationFailuresChangesMetricFilter.name}"
  namespace = "CloudTrailMetrics"
  period = 300
  threshold = 1
  statistic = "Sum"
  alarm_actions = ["${aws_sns_topic.sns_topic.arn}"]
}

resource "aws_cloudwatch_log_metric_filter" "IAMPolicyChangesMetricFilter" {
  log_group_name = "${var.cloudwatch_log_group_name}"
  "metric_transformation" {
    name = "IAMPolicyEventCount"
    namespace = "CloudTrailMetrics"
    value = "1"
  }
  name = "IAMPolicyEventCount"
  pattern = "{ ($.eventName = DeleteGroupPolicy) || ($.eventName = DeleteRolePolicy) || ($.eventName = DeleteUserPolicy) || ($.eventName = PutGroupPolicy) || ($.eventName = PutRolePolicy) ($.eventName = PutUserPolicy) || ($.eventName = CreatePolicy) || ($.eventName = DeletePolicy) || ($.eventName = AttachRolePolicy) || ($.eventName = DetachRolePolicy) || ($.eventName = AttachUserPolicy) || ($.eventName = DetachUserPolicy) || ($.eventName = AttachGroupPolicy) || ($.eventName = DetachGroupPolicy)}"
}

resource "aws_cloudwatch_metric_alarm" "IAMPolicyChangesAlarm" {
  alarm_name = "CloudTrailIAMPolicyChanges"
  alarm_description = ""
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "${aws_cloudwatch_log_metric_filter.IAMPolicyChangesMetricFilter.name}"
  namespace = "CloudTrailMetrics"
  period = 300
  threshold = 1
  statistic = "Sum"
  alarm_actions = ["${aws_sns_topic.sns_topic.arn}"]
}