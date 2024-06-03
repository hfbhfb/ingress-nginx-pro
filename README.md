# ingress-nginx-pro


make uninstall
make install

kubectl get deploy -n myingress -oyaml|grep host

kubectl get po -n myingress -owide


## 测试0
make test1
kubectl get po -owide|grep testinga
kubectl get svc |grep testinga
kubectl get ingress testinga -oyaml
echo "192.168.113.246 testinga.com" >> /etc/hosts
echo "192.168.113.246 testinga.com" >> /c/Windows/System32/drivers/etc/hosts # C:\Windows\System32\drivers\etc\hosts
curl -v http://testinga.com



## 生成helm模板用以学习
make 

make build-template-hw # 华为安装多负本ingress控制器

make install # 以NodePort的方式安装 ingress 控制器

make test1 # 创建测试ingress

make clean1 # 清理测试用ingress




