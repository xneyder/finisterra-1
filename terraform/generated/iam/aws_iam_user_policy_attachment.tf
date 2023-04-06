resource "aws_iam_user_policy_attachment" "dev_smtp_user_ses_sender" {
  policy_arn = "arn:aws:iam::169684386827:policy/ses_sender"
  user       = "dev-smtp-user"
}

resource "aws_iam_user_policy_attachment" "xvello_export_test_xvello_export_test" {
  policy_arn = "arn:aws:iam::169684386827:policy/xvello-export-test"
  user       = "xvello-export-test"
}

