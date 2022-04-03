AWS_ACCOUNT_ID=999999999

aws-iam:
	aws iam create-role --role-name lambda-ex --assume-role-policy-document \
	'{"Version": "2012-10-17",\
	 "Statement": [{"Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'

zip-project:
	zip function.zip main

aws-create-function:
	aws lambda create-function --function-name go-lambda-function-3 \
	--zip-file fileb://function.zip --handler main --runtime go1.x \
	--role arn:aws:iam::$(AWS_ACCOUNT_ID):role/lambda-ex

aws-invoke:
	aws lambda invoke --function-name go-lambda-function-3 \
	--cli-binary-format raw-in-base64-out \
	--payload '{"what is your name?": "Italo", "how old are you?": 33}' output.txt

.PHONY: iam