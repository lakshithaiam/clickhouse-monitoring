sudo systemctl stop k3s
sudo systemctl restart k3s

k delete ns clickhouse monitoring zookeeper

k create ns clickhouse 
k create ns monitoring
k create ns zookeeper

kubectl apply -f https://raw.githubusercontent.com/Altinity/clickhouse-operator/master/deploy/operator/clickhouse-operator-install-bundle.yaml


helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm show values bitnami/zookeeper > zookeeper-values-v1.yaml
helm show values prometheus-community/kube-prometheus-stack > kube-prometheus-values-v1.yaml

https://hooks.slack.com/services/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 << lakshithanoone
https://hooks.slack.com/services/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
#slack-all
#slack-critical
#slack-clickhouse

https://hooks.slack.com/services/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 << v4c 
#test-alerts



helm upgrade --install my-zookeeper bitnami/zookeeper -f zookeeper-values-v1.yaml -n zookeeper
helm upgrade --install my-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-values-v1.yaml -n monitoring


k apply -f clickhouse-installation.yaml
k apply -f clickhouse-service-monitor.yaml
k apply -f prometheus-rule.yaml
helm upgrade my-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-values.yaml -n monitoring
