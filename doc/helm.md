## Operations
#### Copy Chart from Official Repo into Self-Managed Repo
Template
```
helm repo add source-repo <source_repository_url>
helm repo update
helm fetch --repo source-repo <chart_name> --version <chart_version>
helm repo add destination-repo <destination_repository_url>
helm package <chart_name>-<chart_version>.tgz
helm repo update
helm push <chart_name>-<chart_version>.tgz destination-repo
```
Example
```shell
helm repo add victoriametrics https://victoriametrics.github.io/helm-charts/
helm repo update
helm pull victoriametrics/victoria-metrics-operator
helm repo add chartrepo <destination_repository_url>
helm repo update
helm push victoria-metrics-operator-0.21.0.tgz chartrepo
```
#### Create Local Helm Repo and Expose via HTTP
```
helm package .
mv my-chart-1.0.0.tgz  ~hrt/repo/helm-repo
helm repo index .
helm repo add localrepo http://localhost:8512

```
#### Clear the Helm Cache 
If any consistent repo related issues , clear the cache and
```shell
~/.helm/repository
helm repo list 
helm repo update
```