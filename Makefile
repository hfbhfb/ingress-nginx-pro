


helmAppName=ingress1
Space=myingress



build-template:
	rm -Rf template-out-${helmAppName}
	touch values.yaml
	helm template ingress-nginx/ --namespace  ${Space} --values ./values.yaml --name-template ${helmAppName} --output-dir template-out-${helmAppName} --debug
