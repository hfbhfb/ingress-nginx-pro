


helmAppName=ingress1
Space=myingress



build-template:
	rm -Rf template-out-${helmAppName}
	touch values.yaml
	helm template ingress-nginx/ --namespace  ${Space} --values ./values.yaml --name-template ${helmAppName} --output-dir template-out-${helmAppName} --debug

build-template-hw:
	rm -Rf template-out-${helmAppName}
	touch values.yaml
	helm template ingress-nginx/ --namespace  ${Space} --values ./values-hw.yaml --name-template ${helmAppName} --output-dir template-out-${helmAppName} --debug

install:
	- kubectl create ns  ${Space}
	helm install ingress-nginx/ --namespace  ${Space} --values ./values.yaml --name-template ${helmAppName}

uninstall:
	helm uninstall  --namespace  ${Space}  ${helmAppName}

download:
	wget https://github.com/kubernetes/ingress-nginx/releases/download/helm-chart-4.1.3/ingress-nginx-4.1.3.tgz

testapp:
	bash test-ingress.sh
testappclean:
	export clean="true" && bash test-ingress.sh

	