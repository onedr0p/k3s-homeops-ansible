---

https://github.com/bitnami/charts/tree/master/bitnami/metallb

```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install metallb --kubeconfig ./kubeconfig --namespace default --version "0.1.23" --values ./tests/metallb-values.yaml bitnami/metallb
# helm uninstall metallb --kubeconfig ./kubeconfig --namespace default
```

---

https://github.com/kubernetes/ingress-nginx/tree/master/charts/ingress-nginx

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress --kubeconfig ./kubeconfig --namespace default --version "2.16.0" --values ./tests/nginx-ingress-values.yaml ingress-nginx/ingress-nginx
# helm uninstall nginx-ingress --kubeconfig ./kubeconfig --namespace default
```

---

https://github.com/longhorn/longhorn/tree/master/chart

```
helm repo add longhorn https://charts.longhorn.io
helm repo update
kubectl --kubeconfig ./kubeconfig create namespace longhorn-system
helm install longhorn --kubeconfig ./kubeconfig --namespace longhorn-system --version "1.0.2" --values ./tests/longhorn-values.yaml longhorn/longhorn
# helm uninstall longhorn --kubeconfig ./kubeconfig --namespace longhorn-system
```

---

```
helm repo add k8s-at-home https://k8s-at-home.com/charts/
helm repo update
helm install home-assistant --kubeconfig ./kubeconfig --namespace default --version "2.1.0" --values ./tests/home-assistant-values.yaml k8s-at-home/home-assistant
# helm uninstall home-assistant --kubeconfig ./kubeconfig --namespace default
```
