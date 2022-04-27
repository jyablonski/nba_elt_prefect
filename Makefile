.PHONY: prefect-login
prefect-login: 
	prefect auth login --key ${prefect_key}

