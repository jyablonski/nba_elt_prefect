-include $(shell curl -ssl -o .jacobs-makefile "https://raw.githubusercontent.com/jyablonski/python_aws/jacob/Makefile"; echo .jacobs-makefile)

.PHONY: prefect-login
prefect-login: 
	prefect auth login --key ${prefect_key}

