

IngressClassName=myingress3


cat >tmoreingress$IngressClassName.yaml<<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $IngressClassName
spec:
  replicas: 1
  selector:
    matchLabels:
      app: $IngressClassName
  strategy:
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: $IngressClassName
    spec:
      containers:
      - image: nginx    #若使用“开源镜像中心”的镜像，可直接填写镜像名称；若使用“我的镜像”中的镜像，请在SWR中获取具体镜像地址。
        imagePullPolicy: IfNotPresent
        name: nginx
      imagePullSecrets:
      - name: default-secret
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: $IngressClassName
  name: $IngressClassName
spec:
  ports:
  - name: service0
    port: 80                 # 访问Service的端口
    protocol: TCP           # 访问Service的协议，支持TCP和UDP
    targetPort: 80           # Service访问目标容器的端口，本例中nginx镜像默认使用80端口
  selector:                  # 标签选择器，Service通过标签选择Pod，将访问Service的流量转发给Pod
    app: $IngressClassName
  type: ClusterIP            # Service的类型，ClusterIP表示在集群内访问
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $IngressClassName
  namespace: default
spec:
  ingressClassName: $IngressClassName
  rules:
    - host: $IngressClassName.com
      http:
        paths:
          - pathType: Prefix
            backend:
              service:
                name: $IngressClassName
                port:
                  number: 80
            path: /
  # This section is only required if TLS is to be enabled for the Ingress
#  tls:
#    - hosts:
#      - ingressbbb.com
#      secretName: example-tls
EOF


kubectl delete -f tmoreingress$IngressClassName.yaml 

kubectl apply -f tmoreingress$IngressClassName.yaml 

if [ $clean == "true" ]
then
    kubectl delete -f tmoreingress$IngressClassName.yaml 
    echo "已经清理"
    exit 0
else
    kubectl delete -f tmoreingress$IngressClassName.yaml 
    kubectl apply -f tmoreingress$IngressClassName.yaml 
fi

rm -f tmoreingress$IngressClassName.yaml

# 
echo "集群任意节点ip： 192.168.27.246 $IngressClassName.com"
echo 192.168.27.246 $IngressClassName.com >> /etc/hosts
echo  "test for---   curl http://$IngressClassName.com:32080"
